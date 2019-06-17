//
//  GIMTimer.h
//  SuperGone
//
//  Created by  on 2017/5/6.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIMTimer : NSObject

- (void)execute:(id)target action:(SEL)action timeInterval:(NSTimeInterval)timeInterval;

/**
 中断重连定时器
 */
- (void)invalidateTimer;

@end
