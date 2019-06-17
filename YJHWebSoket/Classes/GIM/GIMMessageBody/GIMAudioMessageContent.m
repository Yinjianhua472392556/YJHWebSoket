//
//  GIMAudioMessageContent.m
//  SuperCard
//
//  Created by 王寒标 on 2017/12/24.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMAudioMessageContent.h"

@implementation GIMAudioMessageContent

- (instancetype)initWithChatType:(GIMConversationType)chatType
{
    self = [super init];
    if (self) {
        
        self.messageType = GIMMessageTypeAudio;
        self.chatType = chatType;
    }
    return self;
}

@end
