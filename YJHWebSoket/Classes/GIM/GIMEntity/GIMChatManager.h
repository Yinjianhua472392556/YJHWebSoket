//
//  GIMChatManager.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMMessage.h"

@interface GIMChatManager : NSObject

/**
 收到信息
 
 @param callBack 收到信息时候的回调
 @param tag 若是tag有重复的，则后面的回调是添加不进去的
 */
- (void)messageDidReceived:(void (^)(GIMMessage *))callBack tag:(NSString *)tag;

/**
 根据便签删除收到消息的回调
 
 @param tag 标记
 */
- (void)removeCallBackWithTag:(NSString *)tag;

/**
 发送消息
 
 @param message 发送的消息模型
 @param progress 发送的进度的回调
 @param completion 发送完成之后的回调
 */
- (void)sendMessage:(GIMMessage *)message progress:(void (^)(NSProgress *progress))progress completion:(void (^)(GIMMessage *message, NSError *error))completion;

/**
 清除未读消息

 @param conversationID 指定清除与谁的未读消息
 @param completion 完成请求之后的回调
 */
- (void)clearUnreadMessage:(NSString *)conversationID completion:(void (^)(BOOL success))completion;

/**
 根据messageID获取指定个数的历史消息

 @param conversationID 聊天对象ID
 @param offsetID 参考的消息ID
 @param pagesize 获取的数据尺寸
 @param completion 完成请求之后的回调
 */
- (void)fetchMessages:(NSString *)conversationID offsetID:(NSString *)offsetID pagesize:(NSUInteger)pagesize completion:(void (^)(NSArray *messages, NSError *error, long long offset))completion;

/**
 根据服务器返回的参考字段获取指定个数的历史消息
 
 @param conversationID 聊天对象ID
 @param offset 服务器返回的参考字段,不等于page,是一个类似于messageID的数据
 @param pagesize 获取的数据尺寸
 @param completion 完成请求之后的回调
 */
- (void)fetchMessages:(NSString *)conversationID offset:(long long)offset pagesize:(NSUInteger)pagesize completion:(void (^)(NSArray *messages, NSError *error, long long offset))completion;

/**
 从服务器获取最新的消息,直到参考messageID

 @param conversationID 会话ID
 @param messageID 参考的消息ID
 @param completion 完成请求之后的回调
 */
- (void)fetchMessages:(NSString *)conversationID lastMessageID:(NSString *)messageID completion:(void (^)(NSArray *messages, NSError *error))completion;

@end
