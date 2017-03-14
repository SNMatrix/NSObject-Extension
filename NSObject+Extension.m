//
//  NSObject+Extension.m
//
//  Created by sunny on 2017/3/13.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

-(id)performSelector:(SEL)selector withObjects:(NSArray *)objects
{
    
    //方法签名 - 方法的描述 某个类的某个方法
    NSMethodSignature * sig = [[self class] instanceMethodSignatureForSelector:selector];
    
    if (sig == nil) {//如果传进来的方法名找不到
        //创建一个异常对象 并报错 - 方法1
//        @throw [NSException exceptionWithName:@"方法错误" reason:@"方法找不到" userInfo:nil];
        //创建一个异常对象 并报错 - 方法2
        [NSException raise:@"方法错误" format:@"%@ - 方法找不到",NSStringFromSelector(selector)];
        
        
        //如果不想提示错误
        return nil;
    }
    
    //NSInvocation - 回调:利用一个NSInvocation对象来包装一次方法调用（方法调用者、方法名、参数、返回值）
    NSInvocation * invo = [NSInvocation invocationWithMethodSignature:sig];
    invo.target = self;
    invo.selector = selector;
    
    
    //获得执行函数的参数个数 (要减去 self 和 _cmd）
    NSInteger paramsCount = sig.numberOfArguments - 2;
    
    //如果传了空的参数数组，那么取paramsCount和objects.count的最小值
    paramsCount = MIN(paramsCount,  objects.count);
    //设置参数 参数要传指针 index从2开始
    
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        //如果要传空，请传[NSNull null]。判断如果为空，则跳过不设置
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        [invo setArgument:&object atIndex:i+2];
    }

    //调用方法
    [invo invoke];
    
    //获取返回值
    id returnValue = nil;
    
    //判断要调用的方法是否有返回值
    if (sig.methodReturnLength) {//如果有返回值，才去获取返回值
        [invo getReturnValue:&returnValue];
    }
    
    return returnValue;

}

@end
