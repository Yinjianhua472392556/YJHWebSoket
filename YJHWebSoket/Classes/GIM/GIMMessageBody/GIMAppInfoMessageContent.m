//
//  GIMAppInfoMessageContent.m
//  SuperGone
//
//  Created by  on 2017/8/16.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMAppInfoMessageContent.h"

GIMAppInfoAction const GIMAppInfoActionAPP = @"app";

@implementation GIMAppInfoMessageContent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageType = GIMMessageTypeFunction;
    }
    return self;
}

@end
