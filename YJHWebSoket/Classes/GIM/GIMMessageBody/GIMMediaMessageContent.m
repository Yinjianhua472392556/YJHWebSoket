//
//  GIMMediaMessageContent.m
//  WebSocket
//
//  Created by  on 2017/6/10.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMediaMessageContent.h"

GIMMediaMessageAction GIMMediaMessageActionInvite = @"invite";
GIMMediaMessageAction GIMMediaMessageActionAgree = @"agree";
GIMMediaMessageAction GIMMediaMessageActionRefuse = @"refuse";
GIMMediaMessageAction GIMMediaMessageActionCancel = @"cancel";

@implementation GIMMediaMessageContent

- (instancetype)initWithMessageType:(GIMMessageType)type action:(GIMMediaMessageAction)action
{
    self = [super init];
    if (self) {
        
        self.messageType = type;
        self.action = action;
    }
    return self;
}

@end
