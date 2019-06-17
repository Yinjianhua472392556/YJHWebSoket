//
//  GIMGroupManager.h
//  WebSocket
//
//  Created by  on 2017/5/27.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GIMGroup.h"

@interface GIMGroupManager : NSObject

/**
 创建新群
 
 @param groupName 创建的新群的名称
 @param completion 请求完成时的回调
 */
- (void)createGroup:(NSString *)groupName completion:(void (^)(GIMGroup *group, NSError *error))completion;

/**
 获取群组列表
 
 @param pageIndex 请求的群组的页码
 @param pageSize 每页的数量
 @param completion 请求完成时的回调，请求成功时数组装有群组列表，请求失败时数组为空，error含有错误信息
 */
- (void)getGroupList:(NSString *)pageIndex pageSize:(NSString *)pageSize completion:(void (^)(NSArray *groups, NSError *error))completion;

/**
 加入群
 
 @param groupId 加入的群的ID
 @param completion 完成之后的回调
 */
- (void)joinGroup:(NSString *)groupId completion:(void (^)(NSError *error))completion;
- (void)joinTemporaryGroup:(NSString *)groupId completion:(void (^)(NSError *error))completion;

/**
 离开群组
 
 @param groupId 离开的群组的ID
 @param completion 操作完成时的会调
 */
- (void)leaveGroup:(NSString *)groupId completion:(void (^)(NSError *error))completion;
- (void)leaveTemporaryGroup:(NSString *)groupId completion:(void (^)(NSError *error))completion;

/**
 获取群成员列表
 
 @param groupId 群组的Id
 @param completion 请求完成后的回调
 */
- (void)getGroupMembers:(NSString *)groupId completion:(void (^)(NSArray *members, NSError *error))completion;

/**
 删除群成员
 
 @param groupId 群组ID
 @param members 要删除的人员的ID的数组
 @param completion 请求完成时的回调
 */
- (void)deleteGroupMembers:(NSString *)groupId members:(NSArray *)members completion:(void (^)(NSError *error))completion;

/**
 修改群名称
 
 @param groupId 修改群名称的ID
 @param newName 新名称
 @param completion 完成之后的回调
 */
- (void)updateGroupName:(NSString *)groupId name:(NSString *)newName completion:(void (^)(NSError *error))completion;

#pragma mark - 发消息相关
/**
 发消息给我关注的人
 
 @param content 发送的内容
 @param completion 发送完成时的回调
 */
- (void)sendMessageToMyFocus:(NSString *)content completion:(void (^)(NSError *error))completion;

/**
 发送消息给群组
 
 @param groupId 接收消息的群组ID
 @param message 发送的消息内容
 @param completion 完成时的回调
 */
- (void)sendMessageToGroup:(NSString *)groupId message:(NSString *)message completion:(void (^)(NSError *error))completion;

/**
 发送消息给临时群
 
 @param groupId 接受消息的群组ID
 @param content 消息内容
 @param completion 发送完成时的回调
 */
- (void)sendMessageToTemporaryGroup:(NSString *)groupId content:(NSDictionary *)content completion:(void (^)(NSError *error))completion;

/**
 发送消息给商城的临时群
 
 @param productId 商品ID
 @param message 消息内容
 @param completion 完成时的回调
 */
- (void)sendMessageToTemporaryGroupOfProduct:(NSString *)productId message:(NSString *)message completion:(void (^)(NSError *error))completion;

/**
 获取新群聊天消息
 
 @param groupId 群组ID
 @param completion 完成请求之后的回调
 */
- (void)getHistoryMessage:(NSString *)groupId completion:(void (^)(NSArray *messages, NSError *error))completion;

/**
 获取临时群历史消息
 
 @param groupId 临时群Id
 @param completion 完成后的回调
 */
- (void)getHistoryMessageOfTemporary:(NSString *)groupId completion:(void (^)(NSArray *messages, NSError *error))completion;

@end
