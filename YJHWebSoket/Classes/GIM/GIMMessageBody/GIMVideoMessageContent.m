//
//  GIMVideoMessageContent.m
//  SuperGone
//
//  Created by  on 2017/8/14.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMVideoMessageContent.h"

@implementation GIMVideoMessageContent

- (instancetype)initWithChatType:(GIMConversationType)conversationType {
    
    if (self = [super init]) {
        
        self.messageType = GIMMessageTypeVideo;
        self.chatType = conversationType;
    }
    return self;
}

@end
