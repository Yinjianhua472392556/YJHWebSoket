//
//  GIMChatManager.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMChatManager.h"
#import "GIMRequest.h"
#import "MJExtension.h"
#import "GIMResponse.h"
#import "GIMConfig.h"
#import "GIMImageMessageContent.h"
//#import "SDWebImageManager.h"
#import "GIMDataManager.h"
#import "GIMSocket.h"
#import "GIMTextMessageContent.h"
#import "GIMImageMessageContent.h"
#import "GIMMediaMessageContent.h"
#import "GIMVideoMessageContent.h"
#import "GIMLivingMessageContent.h"
#import "GIMMomentsMessageContent.h"
#import "GIMAppInfoMessageContent.h"
//#import "SCUploadImageToWC.h"
#import "GIMShareMessageContent.h"
#import "GIMCommandMessageContent.h"
#import "GIMRedEnvelopeMessageContent.h"
#import "GIMAudioMessageContent.h"
#import "GIMReceiveRedEnvelopeMessageContent.h"

@interface GIMChatManager ()

@property (nonatomic, strong) NSOperationQueue *messageQueue;

@end

@implementation GIMChatManager

- (void)messageDidReceived:(void (^)(GIMMessage *))callBack tag:(NSString *)tag{
    
    [[GIMSocket sharedSocket] setReceivedMessageCallBack:callBack tag:tag];
}

- (void)removeCallBackWithTag:(NSString *)tag{
    
    [[GIMSocket sharedSocket] removeCallBackWithTag:tag];
}

static NSString * const ImagesServer = @"https://imgs.gonecn.com/";

- (void)sendMessage:(GIMMessage *)message progress:(void (^)(NSProgress *))progress completion:(void (^)(GIMMessage *, NSError *))completion{
    
    [self.messageQueue addOperationWithBlock:^{
        
        if (message.messageType == GIMMessageTypePhoto) {
            
            GIMImageMessageContent *content = (GIMImageMessageContent *)message.content;
            
            int alphaInfo = CGImageGetAlphaInfo(content.image.CGImage);
            BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
                              alphaInfo == kCGImageAlphaNoneSkipFirst ||
                              alphaInfo == kCGImageAlphaNoneSkipLast);
            __block NSData *fileData;
            if (hasAlpha) {
                fileData = UIImagePNGRepresentation(content.image);
            } else {
                
                fileData = UIImageJPEGRepresentation(content.image, 0.8);
            }
            
//            [SCUploadImageToWC uploadImageWithData:fileData fileName:(hasAlpha ? @"png" : @"jpg") success:^(id response) {
//
//                NSString *url = (NSString*)response;
//                content.imageUrl = url;
//                content.image = nil;
//                //使用sdwebimage把图片缓存到本地
////                [[SDWebImageManager sharedManager].imageCache storeImageDataToDisk:fileData forKey:content.imageUrl];
//
//                [GIMRequest sendMessage:[message.content mj_JSONObject] to:message.conversationID progress:progress success:^(NSURLSessionDataTask *task, GIMResponse *response) {
//
//                    message.messageID = [NSString stringWithFormat:@"%@", response.data[@"newmsg"][@"id"]];
//                    message.messageTime = response.data[@"newmsg"][@"create_time"];
//                    if (completion) {
//
//                        completion(message, nil);
//                    }
//
////                    [[GIMDataManager sharedManager] openTable:message.conversationID completion:^(NSError *error) {
////
////                        if (!error) {
////
////                            [[GIMDataManager sharedManager] insertMessageItem:message];
////                        }
////                    }];
//                } faiure:^(NSURLSessionDataTask *task, NSError *error) {
//
//                    if (completion) {
//                        completion(message, error);
//                    }
//
//                    //若是发送消息失败    取本地时间赋值，存进数据库，否则下次取数据的时候会出问题
////                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////                    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
////                    [formatter setTimeZone:[NSTimeZone localTimeZone]];
////                    NSString *stringDate = [formatter stringFromDate:[NSDate date]];
////                    message.messageTime = stringDate;
//
////                    [[GIMDataManager sharedManager] openTable:message.conversationID completion:^(NSError *error) {
////
////                        if (!error) {
////
////                            [[GIMDataManager sharedManager] insertMessageItem:message];
////                        }
////                    }];
//
//
//                }];
//
//            } failure:^(id obj) {
//                if (completion) {
//                    completion(message, obj);
//                }
//            }];
            
        } else {
//            NSLog(@"haha:%@",[message.content mj_JSONObject]);
            [GIMRequest sendMessage:[message.content mj_JSONObject] to:message.conversationID progress:progress success:^(NSURLSessionDataTask *task, GIMResponse *response) {
                
                message.messageID = [NSString stringWithFormat:@"%@", response.data[@"newmsg"][@"id"]];
                message.messageTime = response.data[@"newmsg"][@"create_time"];
                if (completion) {
                    
                    completion(message, nil);
                }
                
//                [[GIMDataManager sharedManager] openTable:message.conversationID completion:^(NSError *error) {
//
//                    if (!error) {
//
//                        [[GIMDataManager sharedManager] insertMessageItem:message];
//                    }
//                }];
                
                
            } faiure:^(NSURLSessionDataTask *task, NSError *error) {
                //若是发送消息失败    取本地时间赋值，存进数据库，否则下次取数据的时候会出问题
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                [formatter setTimeZone:[NSTimeZone localTimeZone]];
                
                NSString *stringDate = [formatter stringFromDate:[NSDate date]];
                message.messageTime = stringDate;
                
//                [[GIMDataManager sharedManager] openTable:message.conversationID completion:^(NSError *error) {
//
//                    if (!error) {
//
//                        [[GIMDataManager sharedManager] insertMessageItem:message];
//                    }
//                }];
                
                if (completion) {
                    completion(message, error);
                }
            }];
        }
    }];
}

- (void)clearUnreadMessage:(NSString *)conversationID completion:(void (^)(BOOL))completion {
    
    [self.messageQueue addOperationWithBlock:^{
        
        GIMRequest *request = [[GIMRequest alloc] init];
        NSDictionary *params = @{@"guserId" : conversationID, @"offset" : @0};
        
        [request Post:@"webchat/historymsg" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if (completion) {
                
                completion([responseObject[@"code"] intValue] == 0);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if (completion) {
                completion(NO);
            }
        }];
    }];
}

- (void)fetchMessages:(NSString *)conversationID offsetID:(NSString *)offsetID pagesize:(NSUInteger)pagesize completion:(void (^)(NSArray *messages, NSError *error, long long offset))completion {
    
    [self.messageQueue addOperationWithBlock:^{
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        GIMRequest *request = [[GIMRequest alloc] init];
        NSDictionary *params = @{@"guserId" : conversationID, @"pageSize" : @(pagesize), @"offsetId" : offsetID};
        
        [request Post:@"webchat/historymsg" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (completion) {
                
                if ([responseObject[@"code"] intValue] == 0) {
                    
                    NSDictionary *dataDict = responseObject[@"data"];
                    NSDictionary *friguserDict = dataDict[@"friguser"];
                    GIMPostUserModel *userModel = [[GIMPostUserModel alloc] init];
                    userModel.ID = [NSString stringWithFormat:@"%@", friguserDict[@"id"]];
                    userModel.nickname = [NSString stringWithFormat:@"%@", friguserDict[@"nickname"]];
                    userModel.location = [NSString stringWithFormat:@"%@", friguserDict[@"location"]];
                    userModel.avatar = [NSString stringWithFormat:@"%@", friguserDict[@"img_face"]];
                    
                    GIMPostUserModel *postUser = [[GIMPostUserModel alloc] init];
                    GIMConfig *config = [GIMConfig sharedConfiguration];
                    postUser.ID = config.ID;
                    postUser.nickname = config.nickName;
                    postUser.location = config.location;
                    postUser.avatar = config.avatar;
                    
                    
                    long long offset = [[NSString stringWithFormat:@"%@",responseObject[@"data"][@"offset"]] longLongValue];
                    
                    NSArray *msgs = responseObject[@"data"][@"msgs"];
                    NSMutableArray *mArr = [NSMutableArray array];
                    [msgs enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj[@"content"][@"chatType"] intValue] != 1) {
                            return;//在块遍历中，return的作用相当于for循环的continue
                        }
                        
                        GIMMessage *message = [[GIMMessage alloc] init];
                        message.messageID = [NSString stringWithFormat:@"%@", obj[@"id"]];
                        message.direction = [userModel.ID isEqualToString:postUser.ID] ? GIMMessageDirectionSend : [obj[@"is_ta"] intValue];//服务器返回的is_ta字段在聊天对象是自己的时候也会是1
                        message.content = [self dealWithMessageContent:obj[@"content"]];
                        message.messageTime = obj[@"create_time"];
                        message.conversationID = userModel.ID;
                        message.messageType = message.content.messageType;
                        message.chatType = message.content.chatType;
                        if (message.direction == GIMMessageDirectionSend) {
                            
                            message.postUser = postUser;
                        } else {
                            
                            message.postUser = userModel;
                        }
                        
                        [mArr addObject:message];
                    }];
                    if (mArr.count > 0) {
                        
                        NSArray *arr = [mArr copy];
                        [[GIMDataManager sharedManager] insertMessages:arr offset:offset lastMessageID:nil completion:completion];
                    } else {
                        
                        completion(mArr, nil, offset);
                    }
                } else {
                    
                    completion(nil, [NSError errorWithDomain:@"com.getHistoryMessage.chat" code:[responseObject[@"code"] intValue] userInfo:@{@"message" : responseObject[@"message"]}], 0);
                }
            }
            dispatch_semaphore_signal(sema);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if (completion) {
                completion(nil, error, 0);
            }
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
}

- (void)fetchMessages:(NSString *)conversationID offset:(long long)offset pagesize:(NSUInteger)pagesize completion:(void (^)(NSArray *messages, NSError *error, long long offset))completion {
    
    [self.messageQueue addOperationWithBlock:^{
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        GIMRequest *request = [[GIMRequest alloc] init];
        NSDictionary *params;
        if (offset > 0) {//大于0，说明是有数据，传参
            
            params = @{@"guserId" : conversationID, @"offset" : @(offset), @"pageSize" : @(pagesize)};
        } else if (offset < 0) {//第一次请求，不传offset
            
            params = @{@"guserId" : conversationID, @"pageSize" : @(pagesize)};
        }
        
        [request Post:@"webchat/historymsg" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (completion) {
                
                if ([responseObject[@"code"] intValue] == 0) {
                    
                    NSDictionary *dataDict = responseObject[@"data"];
                    NSDictionary *friguserDict = dataDict[@"friguser"];
                    GIMPostUserModel *userModel = [[GIMPostUserModel alloc] init];
                    userModel.ID = [NSString stringWithFormat:@"%@", friguserDict[@"id"]];
                    userModel.nickname = [NSString stringWithFormat:@"%@", friguserDict[@"nickname"]];
                    userModel.location = [NSString stringWithFormat:@"%@", friguserDict[@"location"]];
                    userModel.avatar = [NSString stringWithFormat:@"%@", friguserDict[@"img_face"]];
                    
                    GIMPostUserModel *postUser = [[GIMPostUserModel alloc] init];
                    GIMConfig *config = [GIMConfig sharedConfiguration];
                    postUser.ID = config.ID;
                    postUser.nickname = config.nickName;
                    postUser.location = config.location;
                    postUser.avatar = config.avatar;
                    
                    NSString *offsetStr = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"offset"]];
                    
                    long long offset = [offsetStr longLongValue];
                    
                    NSArray *msgs = responseObject[@"data"][@"msgs"];
                    NSMutableArray *mArr = [NSMutableArray array];
                    [msgs enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([obj[@"content"][@"chatType"] intValue] != 1) {
                            return;//在块遍历中，return的作用相当于for循环的continue
                        }
                        
                        GIMMessage *message = [[GIMMessage alloc] init];
                        message.messageID = [NSString stringWithFormat:@"%@", obj[@"id"]];
                        message.direction = [userModel.ID isEqualToString:postUser.ID] ? GIMMessageDirectionSend : [obj[@"is_ta"] intValue];//服务器返回的is_ta字段在聊天对象是自己的时候也会是1
                        message.content = [self dealWithMessageContent:obj[@"content"]];
                        message.messageTime = obj[@"create_time"];
                        message.conversationID = userModel.ID;
                        message.messageType = message.content.messageType;
                        message.chatType = message.content.chatType;
                        if (message.direction == GIMMessageDirectionSend) {
                            
                            message.postUser = postUser;
                        } else {
                            
                            message.postUser = userModel;
                        }
                        
                        [mArr addObject:message];
                    }];
                    if (mArr.count > 0) {
                        
                        NSArray *arr = [mArr copy];
                        [[GIMDataManager sharedManager] insertMessages:arr offset:offset lastMessageID:nil completion:completion];
                    } else {
                        
                        completion(mArr, nil, offset);
                    }
                } else {
                    
                    completion(nil, [NSError errorWithDomain:@"com.getHistoryMessage.chat" code:[responseObject[@"code"] intValue] userInfo:@{@"message" : responseObject[@"message"]}], offset);
                }
            }
            dispatch_semaphore_signal(sema);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if (completion) {
                completion(nil, error, 0);
            }
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
}

- (void)fetchMessages:(NSString *)conversationID lastMessageID:(NSString *)lastMessageID completion:(void (^)(NSArray *messages,NSError *error))completion {
    
    [self.messageQueue addOperationWithBlock:^{
        
        __block BOOL continues = YES;
        __block long long offset = -1;
        __block NSUInteger pageSize = 50;
        __block NSMutableArray *dataArray = [NSMutableArray array];
        
//        do {
        
//            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            __block GIMRequest *request = [[GIMRequest alloc] init];
            NSDictionary *params;
            if (offset > 0) {//大于0，说明是有数据，传参
                
                params = @{@"guserId" : conversationID, @"offset" : @(offset), @"pageSize" : @(pageSize)};
            } else if (offset < 0) {//第一次请求，不传offset
                
                params = @{@"guserId" : conversationID, @"pageSize" : @(pageSize)};
            }
            if (!params) {
                
                NSLog(@"asndfasd");
            }
            NSLog(@"params:%@",params);
            [request Post:@"webchat/historymsg" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                if (completion) {
                    
                    if ([responseObject[@"code"] intValue] == 0) {
                        
                        NSDictionary *dataDict = responseObject[@"data"];
                        NSDictionary *friguserDict = dataDict[@"friguser"];
                        GIMPostUserModel *userModel = [[GIMPostUserModel alloc] init];
                        userModel.ID = [NSString stringWithFormat:@"%@", friguserDict[@"id"]];
                        userModel.nickname = [NSString stringWithFormat:@"%@", friguserDict[@"nickname"]];
                        userModel.location = [NSString stringWithFormat:@"%@", friguserDict[@"location"]];
                        userModel.avatar = [NSString stringWithFormat:@"%@", friguserDict[@"img_face"]];
                        
                        GIMPostUserModel *postUser = [[GIMPostUserModel alloc] init];
                        GIMConfig *config = [GIMConfig sharedConfiguration];
                        postUser.ID = config.ID;
                        postUser.nickname = config.nickName;
                        postUser.location = config.location;
                        postUser.avatar = config.avatar;
                        
                        offset = [responseObject[@"data"][@"offset"] longLongValue];
                        
                        NSArray *msgs = responseObject[@"data"][@"msgs"];
                        NSMutableArray *mArr = [NSMutableArray array];
                        [msgs enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            
                            if ([obj[@"content"][@"chatType"] intValue] != 1) {
                                return;//在块遍历中，return的作用相当于for循环的continue
                            }
                            
                            GIMMessage *message = [[GIMMessage alloc] init];
                            message.messageID = [NSString stringWithFormat:@"%@", obj[@"id"]];
                            message.direction = [userModel.ID isEqualToString:postUser.ID] ? GIMMessageDirectionSend : [obj[@"is_ta"] intValue];//服务器返回的is_ta字段在聊天对象是自己的时候也会是1
                            message.content = [self dealWithMessageContent:obj[@"content"]];
                            message.messageTime = obj[@"create_time"];
                            message.conversationID = userModel.ID;
                            message.messageType = message.content.messageType;
                            message.chatType = message.content.chatType;
                            if (message.direction == GIMMessageDirectionSend) {
                                
                                message.postUser = postUser;
                            } else {
                                
                                message.postUser = userModel;
                            }
                            if ([message.messageID isEqualToString:lastMessageID]) {//若是消息ID等于最后一条消息的ID,直接停止遍历
                                
                                *stop = YES;
                                continues = NO;
                                return;
                            }
                            
                            [mArr addObject:message];
                        }];
                        
                        [dataArray addObjectsFromArray:mArr];
//                        if (!continues) {
                        
                            [[GIMDataManager sharedManager] insertMessages:[dataArray copy] offset:0 lastMessageID:lastMessageID completion:^(NSArray *messages, NSError *error, long long offset) {
                                
                                completion(messages, error);
                            }];
//                        }
                    } else {
                        
                        NSLog(@"responseObject[message]:%@",responseObject[@"message"]);
                        continues = NO;
                        completion(nil, [NSError errorWithDomain:@"com.getHistoryMessage.chat" code:[responseObject[@"code"] intValue] userInfo:@{@"message" : responseObject[@"message"]}]);
                    }
                }
//                dispatch_semaphore_signal(sema);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                continues = NO;
                if (completion) {
                    completion(nil, error);
                }
//                dispatch_semaphore_signal(sema);
            }];
            
//            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        } while (continues);
    }];
}

- (GIMMessageContent *)dealWithMessageContent:(NSDictionary *)content{
    
    GIMMessageContent *messageContent;
    GIMMessageType type = [content[@"messageType"] unsignedIntValue];
    
    switch (type) {
        case GIMMessageTypeText:
            messageContent = [GIMTextMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeAudio:
            messageContent = [GIMAudioMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypePhoto:
            messageContent = [GIMImageMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeMusic:
        case GIMMessageTypeMovie:
            messageContent = [GIMMediaMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeLiving:
            messageContent = [GIMLivingMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeTopic:
            messageContent = [GIMMomentsMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeVideo:
            messageContent= [GIMVideoMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeFunction:
            messageContent = [GIMAppInfoMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeShare:
        case GIMMessageTypeCollection:
            messageContent = [GIMShareMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeCommand:
            messageContent = [GIMCommandMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeSendRedEnvelope:
            return [GIMRedEnvelopeMessageContent mj_objectWithKeyValues:content];
            break;
        case GIMMessageTypeReceiveRedEnvelope:
            return [GIMReceiveRedEnvelopeMessageContent mj_objectWithKeyValues:content];
            break;
            
        default:
            break;
    }
    
    return messageContent;
}


- (NSOperationQueue *)messageQueue{
    
    if (!_messageQueue) {
        
        _messageQueue = [[NSOperationQueue alloc] init];
        _messageQueue.maxConcurrentOperationCount = 5;
        _messageQueue.qualityOfService = NSQualityOfServiceBackground;
    }
    
    return _messageQueue;
}

@end
