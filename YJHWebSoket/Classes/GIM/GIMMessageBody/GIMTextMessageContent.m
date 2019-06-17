//
//  GIMTextMessageBody.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMTextMessageContent.h"

@implementation GIMTextMessageContent

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = [text copy];
        self.messageType = GIMMessageTypeText;
    }
    return self;
}

@end
