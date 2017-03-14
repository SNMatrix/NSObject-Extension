//
//  NSObject+Extension.h

//
//  Created by sunny on 2017/3/13.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
