//
//  GIMMessage.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessage.h"
#import "MJExtension.h"
#import "GIMImageMessageContent.h"
#import "GIMTextMessageContent.h"
#import "GIMLivingMessageContent.h"
#import "GIMMomentsMessageContent.h"
#import "GIMConfig.h"
#import "GIMMediaMessageContent.h"
#import "GIMVideoMessageContent.h"
#import "GIMAppInfoMessageContent.h"
#import "GIMShareMessageContent.h"
#import "GIMCommandMessageContent.h"
#import "GIMRedEnvelopeMessageContent.h"
#import "GIMReceiveRedEnvelopeMessageContent.h"
#import "GIMAudioMessageContent.h"
#import "GIMLivingMessagePostContent.h"
#import "GIMScanCardInfoContent.h"

@implementation GIMMessage

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"messageID" : @"id",
             @"postUser" : @"post_user",
             @"socialGroup" : @"sgroup",
             @"user" : @"user"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"content"]) {
        
        NSDictionary *dict = [oldValue mj_JSONObject];
        GIMMessageType messageType = [dict[@"messageType"] intValue];
        switch (messageType) {
            case GIMMessageTypeText:
                return [GIMTextMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypePhoto:
                return [GIMImageMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeLiving:
                return [GIMLivingMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeMovie:
            case GIMMessageTypeMusic:
                return [GIMMediaMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeVideo:
                return [GIMVideoMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeFunction:
                return [GIMAppInfoMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeShare:
            case GIMMessageTypeCollection:
                return [GIMShareMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeCommand:
                return [GIMCommandMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeSendRedEnvelope:
                return [GIMRedEnvelopeMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeReceiveRedEnvelope:
                return [GIMReceiveRedEnvelopeMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeAudio:
                return [GIMAudioMessageContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeSCLiving:
                return [GIMLivingMessagePostContent mj_objectWithKeyValues:dict];
                break;
            case GIMMessageTypeSCCardScan:
                return [GIMScanCardInfoContent mj_objectWithKeyValues:dict];
                break;
            default: {
                
                if ([[dict allKeys] containsObject:@"content"]) {
                    
                    return [GIMMomentsMessageContent mj_objectWithKeyValues:dict];
                }
            }
                break;
        }
    }
    return oldValue;
}

- (void)mj_keyValuesDidFinishConvertingToObject{
        GIMConfig *config = [GIMConfig sharedConfiguration];
    if ([self.postUser.ID isEqualToString:config.ID]) {
        
        self.direction = GIMMessageDirectionSend;
    } else {
        
        self.direction = GIMMessageDirectionReceived;
        self.conversationID = self.postUser.ID;
    }
    self.messageType = self.content.messageType;
    self.chatType = self.content.chatType;
}

- (instancetype)initWithConversationID:(NSString *)conversationID content:(GIMMessageContent *)content conversationType:(GIMConversationType)conversationType{
    
    GIMMessage *message = [[GIMMessage alloc] init];
    content.chatType = conversationType;
    message.conversationID = conversationID;
    message.content = content;
    message.chatType = conversationType;
    message.direction = GIMMessageDirectionSend;
    message.messageType = content.messageType;
    GIMPostUserModel *postuser = [[GIMPostUserModel alloc] init];
    GIMConfig *config = [GIMConfig sharedConfiguration];
    postuser.ID = config.ID;
    postuser.nickname = config.nickName;
    postuser.avatar = config.avatar;
    postuser.location = config.location;
    message.postUser = postuser;
    
    return message;
}

- (GIMPostUserModel *)postUser {
    
    if (_postUser == nil) {
        
        _postUser = _user == nil ? _u : _user;
    }
    return _postUser;
}

- (GIMPostUserModel *)user {
    
    if (_user == nil) {
        
        _user = _postUser == nil ? _u : _postUser;
    }
    return _user;
}

- (GIMPostUserModel *)u {
    
    if (_u == nil) {
        
        _u = _postUser == nil ? _user : _postUser;
    }
    
    return _u;
}

@end
