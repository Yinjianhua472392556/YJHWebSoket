//
//  GIMMessage.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMMessageContent.h"
#import "GIMPostUserModel.h"
#import "GIMSocialGroup.h"
@class FMResultSet;

typedef NS_ENUM(NSUInteger, GIMMessageDirection) {
    
    GIMMessageDirectionSend,    //发送消息
    GIMMessageDirectionReceived //接收消息
};

@interface GIMMessage : NSObject

/**
 消息ID
 */
@property (nonatomic, copy) NSString *messageID;

/**
 聊天对象的ID
 */
@property (nonatomic, copy) NSString *conversationID;

/**
 消息内容
 */
@property (nonatomic, strong) GIMMessageContent *content;

/**
 发消息的人的消息
 */
@property (nonatomic, strong) GIMPostUserModel *postUser;
@property (nonatomic, strong) GIMPostUserModel *user;
@property (nonatomic, strong) GIMPostUserModel *u;

/**
 表示消息的方向
 */
@property (nonatomic) GIMMessageDirection direction;

/**
 消息时间
 */
@property (nonatomic, copy) NSString *messageTime;

/**
 消息类型
 */
@property (nonatomic) GIMMessageType messageType;

/**
 聊天类型
 */
@property (nonatomic) GIMConversationType chatType;

/**
 社群模型
 */
@property (nonatomic, strong) GIMSocialGroup *socialGroup;

/**
 扩展属性
 */
@property (nonatomic) id ext;

/**
 初始化message
 
 @param conversationID 会话ID
 @param content 消息体模型
 @param conversationType 会话类型
 @return 构造的message模型
 */
- (instancetype)initWithConversationID:(NSString *)conversationID content:(GIMMessageContent *)content conversationType:(GIMConversationType)conversationType;

@end
