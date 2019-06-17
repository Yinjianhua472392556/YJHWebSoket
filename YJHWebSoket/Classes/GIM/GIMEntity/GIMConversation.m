//
//  GIMConversation.m
//  WebSocket
//
//  Created by  on 2017/5/20.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMConversation.h"
#import "GIMDataManager.h"

@implementation GIMConversation

- (void)loadMessageFrom:(GIMMessage *)message count:(NSUInteger)count searchDirection:(GIMMessageSearchDirection)searchDirection completion:(void (^)(NSArray *, NSError *, BOOL))complection{
    
    NSString *messageTime = message == nil ? @"" : message.messageTime;
    count = count == 0 ? 1 : count;
    [[GIMDataManager sharedManager] loadMessages:self.conversationID from:messageTime count:count direction:searchDirection completion:complection];
}

- (void)setConversationID:(NSString *)conversationID {
    
    _conversationID = conversationID;
//    [[GIMDataManager sharedManager] openNewDataBase];
    [[GIMDataManager sharedManager] openTable:conversationID completion:^(NSError *error) {}];
}

- (GIMMessage *)firstMessage {
    
    return [[GIMDataManager sharedManager] getFirstMessage:self.conversationID];
}

@end
