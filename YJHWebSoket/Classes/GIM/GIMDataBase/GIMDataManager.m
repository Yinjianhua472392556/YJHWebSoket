//
//  GIMDataManager.m
//  WebSocket
//
//  Created by  on 2017/5/18.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMDataManager.h"
#import "GIMConfig.h"
#import "GIMMessage.h"
#import "GIMClient.h"
#import "MJExtension.h"

static NSMutableArray *_conversations;

@interface GIMDataManager ()

@property (nonatomic, copy) NSString *tableName;

@end

@implementation GIMDataManager

static GIMDataManager *mgr = nil;

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        mgr = [[GIMDataManager alloc] init];
        mgr.DBQueue = [FMDatabaseQueue databaseQueueWithPath:[mgr dataBasePath]];
    });
    
    return mgr;
}

- (void)openNewDataBase {
    
    mgr.DBQueue = [FMDatabaseQueue databaseQueueWithPath:[mgr dataBasePath]];
}

- (GIMMessage *)getFirstMessage:(NSString *)conversationID {
    
    __block GIMMessage *message;
    
    [self.DBQueue inDatabase:^(FMDatabase * _Nonnull db) {
        self.tableName = [NSString stringWithFormat:@"tb_gone_%@", [conversationID stringByReplacingOccurrencesOfString:@"-" withString:@"_"]];
        NSString *firstSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE messageTime = (SELECT MIN(messageTime) FROM %@)", self.tableName, self.tableName];
        
        FMResultSet *result = [db executeQuery:firstSql];
        if (result) {//如果查询出来结果，则进行遍历
            
            while ([result next]) {
                
                NSString *jsonStr = [result stringForColumn:@"content"];
                message = [GIMMessage mj_objectWithKeyValues:jsonStr];
            }
        }
    }];
    
    return message;
}

- (GIMMessage *)getLastMessage:(NSString *)conversationID {
    
    __block GIMMessage *message;
    
    [self.DBQueue inDatabase:^(FMDatabase * _Nonnull db) {
        self.tableName = [NSString stringWithFormat:@"tb_gone_%@", [conversationID stringByReplacingOccurrencesOfString:@"-" withString:@"_"]];
        NSString *firstSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE messageTime = (SELECT MAX(messageTime) FROM %@)", self.tableName, self.tableName];
        
        FMResultSet *result = [db executeQuery:firstSql];
        if (result) {//如果查询出来结果，则进行遍历
            
            while ([result next]) {
                
                NSString *jsonStr = [result stringForColumn:@"content"];
                message = [GIMMessage mj_objectWithKeyValues:jsonStr];
            }
        }
    }];
    
    return message;
}

- (void)openTable:(NSString *)conversationID completion:(void (^)(NSError *))complection{
    
    //服务器返回数据的userID中含有减号，创建数据库时会报错，所以替换成下划线
    if ([conversationID isEqualToString:@"(null)"] || !conversationID) {
        
        complection(nil);
        return;
    }
    self.tableName = [NSString stringWithFormat:@"tb_gone_%@", [conversationID stringByReplacingOccurrencesOfString:@"-" withString:@"_"]];
    __block BOOL result;
    __block FMDatabase *dataBase;
    [self.DBQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString * messageSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (row INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL, messageID TEXT UNIQUE, messageTime DATETIME DEFAULT(DATETIME('now', 'localtime')), content TEXT,messageType INTEGER)", mgr.tableName];
        result = [db executeUpdate:messageSql];
        if (!result) {
            dataBase = db;
        }
    }];
    if (complection) {
        complection(result ? nil : [dataBase lastError]);
    }
}

- (void)insertMessageItem:(GIMMessage *)message{
    
    [self.DBQueue inDatabase:^(FMDatabase *db) {
        
        if (message.messageTime.length > 0) {
            
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (messageID, messageTime, content, messageType) VALUES (?, ?, ?, ?)", self.tableName];
            NSString *jsonStr = [message mj_JSONString];
            [db executeUpdate:insertSql, message.messageID, message.messageTime, jsonStr, @(message.content.messageType)];
        } else {
            
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (messageID, content, messageType) VALUES (?, ?, ?)", self.tableName];
            NSString *jsonStr = [message mj_JSONString];
            [db executeUpdate:insertSql, message.messageID, jsonStr, @(message.content.messageType)];
        }
    }];
}

- (void)insertMessages:(NSArray *)messages offset:(long long)offset lastMessageID:(NSString *)lastMessageID completion:(void (^)(NSArray *, NSError *, long long))completion {
    
    __block NSArray<GIMMessage *> *msgs = messages;
    __block BOOL result;
    __block NSMutableArray *tempArr = [NSMutableArray array];
    __block NSError *lastError;
    [self.DBQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        [msgs enumerateObjectsUsingBlock:^(GIMMessage * _Nonnull message, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (message.chatType != 1 || message.content == nil) return;
                
            //这里用insert，不能用replace，当insert失败的时候，说明数据库中已经存在这条消息，因为是倒序插入，所以直接停止插入即可。同是把插入成功的数据添加到临时数组
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ (messageID, messageTime, content, messageType) VALUES (?, ?, ?, ?)", self.tableName];
            NSString *jsonStr = [message mj_JSONString];
            result = [db executeUpdate:insertSql, message.messageID, message.messageTime, jsonStr, @(message.content.messageType)];
            
            if (result) {//若是插入成功，插入数组，返回给页面展示。
                
                [tempArr insertObject:message atIndex:0];
            } else {
                
                lastError = [db lastError];
                *stop = YES;//如插入失败，停止遍历
            }
        }];
        
        if (lastError != nil) {
            lastError = [NSError errorWithDomain:@"com.getHistoryMessage.chat" code:lastError.code userInfo:lastError.userInfo];
        }
        completion([tempArr copy], lastError, offset);
    }];
}

- (void)loadMessages:(NSString *)conversationID from:(NSString *)messageTime count:(NSUInteger)count direction:(GIMMessageSearchDirection)direction completion:(void (^)(NSArray *, NSError *, BOOL))complection{
    
    [self.DBQueue inDatabase:^(FMDatabase *db) {
        NSString *querySql;
        if (messageTime.length > 0) {
            
            querySql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE messageTime %@ '%@' ORDER BY messageTime %@ LIMIT %ld", self.tableName, direction == GIMMessageSearchDirectionUp ? @"<" : @">", messageTime, direction == GIMMessageSearchDirectionUp ? @"DESC" : @"ASC", count];
            if (direction == GIMMessageSearchDirectionUp) {
                querySql = [NSString stringWithFormat:@"SELECT * FROM (%@) ORDER BY messageTime", querySql];
            }
        } else {//没有messagetime的数据，说明是查找第一批数据
            /**
             1.在没有messageTime的情况下，给定的direction是没有效果的
             2.没有messageTime的时候，只考虑向上搜索的情况
             */
            querySql = [NSString stringWithFormat:@"SELECT * FROM (SELECT * FROM %@ ORDER BY messageTime DESC LIMIT %ld) ORDER BY messageTime", self.tableName, count];
        }
        
        NSError *error = nil;
        NSMutableArray *modelArr = [NSMutableArray array];
        FMResultSet *result = [db executeQuery:querySql];
        if (result) {//如果查询出来结果，则进行遍历
            
            while ([result nextWithError:&error]) {
                
                NSString *jsonStr = [result stringForColumn:@"content"];
                GIMMessage *message = [GIMMessage mj_objectWithKeyValues:jsonStr];
                if (message) {
                    
                     [modelArr addObject:message];
                }
               
            }
        } else {//若是没有结果，则寻找错误信息
            
            error = [db lastError];
        }
        
        NSString *firstSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE messageTime = (SELECT MIN(messageTime) FROM %@)", self.tableName, self.tableName];
        
        result = [db executeQuery:firstSql];
        GIMMessage *firstMessage;
        if (result) {//如果查询出来结果，则进行遍历
            
            while ([result next]) {
                
                NSString *jsonStr = [result stringForColumn:@"content"];
                firstMessage = [GIMMessage mj_objectWithKeyValues:jsonStr];
            }
        }
        GIMMessage *firstQueryMessage = modelArr.firstObject;
        
        if (complection) {
            complection(modelArr, error, [firstMessage.messageID isEqualToString:firstQueryMessage.messageID]);
        }
    }];
}

- (NSString *)dataBasePath{
    
    NSString *dataBaseName = [NSString stringWithFormat:@"%@.sqlite", [GIMConfig sharedConfiguration].ID];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dataBaseName];
    
    return path;
}

@end

