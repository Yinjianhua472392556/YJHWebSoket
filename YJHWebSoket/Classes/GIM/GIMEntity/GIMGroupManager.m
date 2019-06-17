//
//  GIMGroupManager.m
//  WebSocket
//
//  Created by  on 2017/5/27.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMGroupManager.h"
#import "MJExtension.h"
#import "GIMResponse.h"
#import "GIMGroupMember.h"
#import "GIMMessageContent.h"
#import "GIMImageMessageContent.h"
#import "GIMTextMessageContent.h"
#import "GIMLivingMessageContent.h"
#import "GIMPostUserModel.h"
#import "GIMMessage.h"
#import "GIMConfig.h"
#import "GIMRequest.h"

@implementation GIMGroupManager

- (void)createGroup:(NSString *)groupname completion:(void (^)(GIMGroup *, NSError *))completion{
    
    
    GIMRequest *request = [[GIMRequest alloc] init];
    [request Post:@"webchat/group/new-group" parameters:@{@"name" : groupname} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                
                GIMGroup *group = [GIMGroup mj_objectWithKeyValues:responseObject[@"data"][@"newgroup"]];
                
                completion(group, nil);
            }  else {
                
                NSError *error = [NSError errorWithDomain:@"com.create.group" code:[responseObject[@"code"] integerValue] userInfo:@{@"code" : responseObject[@"code"], @"message" : responseObject[@"message"], @"success" : responseObject[@"success"]}];
                completion(nil, error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)getGroupList:(NSString *)pageIndex pageSize:(NSString *)pageSize completion:(void (^)(NSArray *, NSError *))completion {
    
    GIMRequest *request = [[GIMRequest alloc] init];
    
    [request Post:@"webchat/group/mylist" parameters:@{@"pageIndex" : pageIndex == nil ? @"0" : pageIndex, @"pageSize" : pageSize == nil ? @"0" : pageSize} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                
                NSArray *array = [GIMGroup mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"groups"]];
                completion(array, nil);
            } else {
                
                NSError *error = [NSError errorWithDomain:@"com.getGroupList.group" code:[responseObject[@"code"] integerValue] userInfo:@{@"code" : responseObject[@"code"], @"message" : responseObject[@"message"], @"success" : responseObject[@"success"]}];
                completion(nil, error);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (completion) {
            completion(nil,error);
        }
    }];
}

- (void)joinGroup:(NSString *)groupId completion:(void (^)(NSError *))completion {
    
    [self handle:@"webchat/group/join" parameters:@{@"groupId" : groupId} errorDomain:@"com.joinGroup.group" completion:completion];
}

- (void)joinTemporaryGroup:(NSString *)groupId completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/tempgroup/join" parameters:@{@"groupId" : groupId} errorDomain:@"com.joinTemporaryGroup.group" completion:completion];
}

- (void)leaveGroup:(NSString *)groupId completion:(void (^)(NSError *))completion {
    
    [self handle:@"webchat/group/leave" parameters:@{@"groupId" : groupId} errorDomain:@"com.leaveGroup.group" completion:completion];
}

- (void)leaveTemporaryGroup:(NSString *)groupId completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/tempgroup/leave" parameters:@{@"groupId" : groupId} errorDomain:@"com.leaveTemporaryGroup.group" completion:completion];
}

- (void)getGroupMembers:(NSString *)groupId completion:(void (^)(NSArray *, NSError *))completion{
    
    GIMRequest *request = [[GIMRequest alloc] init];
    
    [request Post:@"webchat/group/members" parameters:@{@"groupId" : groupId} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            
            if ([responseObject[@"code"] integerValue] == 0) {
                
                NSArray *array = responseObject[@"data"][@"gusers"];
                NSArray *members = [GIMGroupMember mj_objectArrayWithKeyValuesArray:array];
                completion(members, nil);
            } else {
                
                NSError *error = [NSError errorWithDomain:@"com.getMembers.group" code:[responseObject[@"code"] intValue] userInfo:@{@"message" : responseObject[@"message"]}];
                completion(nil, error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (void)deleteGroupMembers:(NSString *)groupId members:(NSArray *)members completion:(void (^)(NSError *))completion {
    
    [self handle:@"webchat/group/del-member" parameters:@{@"groupId" : groupId, @"guserIds" : members} errorDomain:@"com.deleteMembers.group" completion:completion];
}

- (void)updateGroupName:(NSString *)groupId name:(NSString *)newName completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/group/del-member" parameters:@{@"groupId" : groupId, @"name" : newName} errorDomain:@"com.updateGroupName.group" completion:completion];
}

- (void)sendMessageToMyFocus:(NSString *)content completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/sendmsg-to-myfriends" parameters:@{@"content" : content} errorDomain:@"com.sendMessageToMyFocus.group" completion:completion];
}

- (void)sendMessageToGroup:(NSString *)groupId message:(NSString *)message completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/sendmsg-group" parameters:@{@"groupId" : groupId, @"content" : message} errorDomain:@"com.sendMessageToGroup.group" completion:completion];
}

- (void)sendMessageToTemporaryGroup:(NSString *)groupId content:(NSDictionary *)content completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/sendmsg-tempgroup" parameters:@{@"tempGroupId" : groupId, @"content" : [content mj_JSONString]} errorDomain:@"com.sendMessageToTemporaryGroup.group" completion:completion];
}

- (void)sendMessageToTemporaryGroupOfProduct:(NSString *)productId message:(NSString *)message completion:(void (^)(NSError *))completion{
    
    [self handle:@"webchat/sendmsg-tempgroup-mallproduct" parameters:@{@"id" : productId, @"content" : message} errorDomain:@"com.sendMessageTotemporaryGroupOfProduct.group" completion:completion];
}

- (void)getHistoryMessage:(NSString *)groupId completion:(void (^)(NSArray *, NSError *))completion{
    
    [self groupMessageHistory:@"webchat/historymsg-group" group:groupId parameter:@{@"groupId" : groupId} completion:completion];
}

- (void)getHistoryMessageOfTemporary:(NSString *)groupId completion:(void (^)(NSArray *, NSError *))completion {
    
    [self groupMessageHistory:@"webchat/historymsg-tempgroup" group:groupId parameter:@{@"tempGroupId" : groupId} completion:completion];
}

- (void)groupMessageHistory:(NSString *)url group:(NSString *)groupId parameter:(id)params completion:(void (^)(NSArray *, NSError *))completion {
    
    GIMRequest *request = [[GIMRequest alloc] init];
    [request Post:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                
                NSArray *dataArr = responseObject[@"data"][@"msgs"];
                NSMutableArray *messages = [NSMutableArray array];
                [dataArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSDictionary *userDict = obj[@"u"];
                    GIMPostUserModel *user = [[GIMPostUserModel alloc] init];
                    user.ID = userDict[@"id"];
                    user.nickname = userDict[@"nickname"];
                    user.location = userDict[@"location"];
                    user.avatar = userDict[@"img_face"];
                    
                    GIMMessage *message = [[GIMMessage alloc] init];
                    message.postUser = user;
                    message.messageID = obj[@"id"];
                    message.conversationID = groupId;
                    message.content = [self dealWithMessageContent:obj[@"content"]];
                    message.direction = [user.ID isEqualToString:[GIMConfig sharedConfiguration].ID] ? GIMMessageDirectionSend : GIMMessageDirectionReceived;
                    message.messageTime = obj[@"create_time"];
                    message.messageType = message.content.messageType;
                    message.chatType = message.content.chatType;
                    [messages addObject:message];
                }];
                completion([messages copy], nil);
            } else {
                
                NSError *error = [NSError errorWithDomain:@"com.create.group" code:[responseObject[@"code"] integerValue] userInfo:@{@"code" : responseObject[@"code"], @"message" : responseObject[@"message"], @"success" : responseObject[@"success"]}];
                completion(nil, error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

- (GIMMessageContent *)dealWithMessageContent:(NSDictionary *)content{
    
    GIMMessageContent *messageContent;
    GIMMessageType type = [content[@"messageType"] unsignedIntValue];
    
    switch (type) {
        case GIMMessageTypeText:
            messageContent = [GIMTextMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypePhoto:
            messageContent = [GIMImageMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeLiving:
            messageContent = [GIMLivingMessageContent mj_objectWithKeyValues:content];
            
        default:
            break;
    }
    
    return messageContent;
}

- (void)handle:(NSString *)url parameters:(id)params errorDomain:(NSString *)domain completion:(void (^)(NSError *error))completion{
    
    GIMRequest *request = [[GIMRequest alloc] init];
    
    [request Post:url parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            
            if ([responseObject[@"code"] integerValue] == 0) {
                
                completion(nil);
            } else {
                
                NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"code"] intValue] userInfo:@{@"message" : responseObject[@"message"]}];
                completion(error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
}

@end
