//
//  GIMTimer.m
//  SuperGone
//
//  Created by  on 2017/5/6.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMTimer.h"
#import <objc/message.h>

@interface GIMTimer ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic) NSTimeInterval timeInterval;

@end

@implementation GIMTimer

- (void)execute:(id)target action:(SEL)action timeInterval:(NSTimeInterval)timeInterval{
    
    if ([self.target isEqual:target] && action == self.action) {
        return;
    }
    ((void * (*)(id, SEL))objc_msgSend)(target, action);
    self.target = target;
    self.action = action;
    self.timeInterval = timeInterval;
    [self startTimer];
}

- (void)invalidateTimer{
    
    if (self.timer) {
        
        [self.timer invalidate];
        self.timer = nil;
        self.target = nil;
        self.action = NULL;
    }
}

#pragma makr --- 开启多线程 ---
- (void)startTimer {
    
    //开一个多线程，让定时器每隔一段时间，就请求一次数据
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
                                                                     selector:@selector(threadMethod)
                                                                       object:nil];
    [queue addOperation:op];
}
- (void)threadMethod {
    
    @autoreleasepool {
        
        if(!self.timer) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                          target:self
                                                        selector:@selector(timerEvent:)
                                                        userInfo:nil
                                                         repeats:YES];
        }
    }
    [[NSRunLoop currentRunLoop] run];
}

#pragma makr --- 定时器方法 ---

- (void)timerEvent:(NSTimer *)timer
{
    if ([self.target respondsToSelector:self.action]) {
        //回到主线程实现方法
        [self.target performSelectorOnMainThread:self.action withObject:timer waitUntilDone:YES];
    }
}

@end
