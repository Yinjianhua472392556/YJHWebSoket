//
//  GIMConversation.h
//  WebSocket
//
//  Created by  on 2017/5/20.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMMessage.h"

typedef NS_ENUM(NSUInteger, GIMMessageSearchDirection) {
    
    GIMMessageSearchDirectionUp,
    GIMMessageSearchDirectionDown
};

@interface GIMConversation : NSObject

/**
 会话唯一标识
 */
@property (nonatomic, copy) NSString *conversationID;

/**
 会话类型,单聊、群聊
 */
@property (nonatomic) GIMConversationType conversationType;

/**
 本地存储的第一条消息
 */
@property (nonatomic, strong) GIMMessage *firstMessage;

/**
 检索消息
 
 @param message 参考的消息,若为空，则从最新处获取
 @param count 获取的消息数量
 @param searchDirection 搜索消息的方向
 @param complection 搜索完成时的回调
 */
- (void)loadMessageFrom:(GIMMessage *)message count:(NSUInteger)count searchDirection:(GIMMessageSearchDirection)searchDirection completion:(void (^)(NSArray *messages, NSError *error, BOOL isFirst))complection;

@end
