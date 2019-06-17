//
//  GIMGroup.h
//  WebSocket
//
//  Created by  on 2017/5/27.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIMGroupCreator : NSObject

/** 创建者的ID */
@property (nonatomic, copy) NSString *ID;

/**  头像 */
@property (nonatomic, copy) NSString *avatar;

/** 创建者地址 */
@property (nonatomic, copy) NSString *location;

/** 创建者昵称 */
@property (nonatomic, copy) NSString *nickName;

@end




@interface GIMGroup : NSObject

/** 群组的ID */
@property (nonatomic, copy) NSString *groupId;

/** 群组的所有者Id */
@property (nonatomic, copy) NSString *owner;

/** 群组的成员数量 */
@property (nonatomic) NSUInteger membersCount;

/** 群组的成员列表 */
@property (nonatomic, copy) NSArray *members;

/** 群名称 */
@property (nonatomic, copy) NSString *groupName;

/** 群创建时间 */
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *time;

/** 群组的创建者 */
@property (nonatomic, strong) GIMGroupCreator *creator;

/**
 初始化群模型

 @param groupId 群ID
 @return 群组模型
 */
+ (instancetype)groupWithId:(NSString *)groupId;

@end
