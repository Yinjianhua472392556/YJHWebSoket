//
//  GIMDataManager.h
//  WebSocket
//
//  Created by  on 2017/5/18.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMConversation.h"
#import "FMDB.h"

@class GIMMessage;

@interface GIMDataManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *DBQueue;

+ (instancetype)sharedManager;

/**
 获取会话的本地数据第一条数据

 @param conversationID 会话ID
 @return 本地存储的第一条消息
 */
- (GIMMessage *)getFirstMessage:(NSString *)conversationID;


/**
 获取本地数据的最后一条

 @param conversationID 会话ID
 @return 最后一条消息
 */
- (GIMMessage *)getLastMessage:(NSString *)conversationID;

/**
 打开相关的会话数据库

 @param conversationID 会话ID,根据此字段打开数据库
 */
- (void)openTable:(NSString *)conversationID completion:(void (^)(NSError *error))complection;

/**
 插入收到的消息
 
 @param message 收到的消息模型
 */
- (void)insertMessageItem:(GIMMessage *)message;
- (void)insertMessages:(NSArray *)messages offset:(long long)offset lastMessageID:(NSString *)lastMessageID completion:(void (^)(NSArray *, NSError *, long long))completion;

/**
 检索消息
 
 @param messageTime 参考的消息,若为空，则从最新处获取
 @param count 获取的消息数量
 @param direction 搜索消息的方向
 @param complection 搜索完成时的回调
 */
- (void)loadMessages:(NSString *)conversationID from:(NSString *)messageTime count:(NSUInteger)count direction:(GIMMessageSearchDirection)direction completion:(void (^)(NSArray *messages, NSError *error, BOOL isFirst))complection;


/** 退出在登录是需要重新打开新的数据库 */
- (void)openNewDataBase;
@end
