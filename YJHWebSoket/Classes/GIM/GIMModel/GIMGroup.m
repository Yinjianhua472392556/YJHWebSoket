//
//  GIMGroup.m
//  WebSocket
//
//  Created by  on 2017/5/27.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMGroup.h"
#import "MJExtension.h"

@implementation GIMGroup

+ (instancetype)groupWithId:(NSString *)groupId{
    
    GIMGroup *group = [[GIMGroup alloc] init];
    
    group.groupId = groupId;
    
    return group;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"groupId" : @"id",
             @"groupName" : @"name",
             @"owner" : @"creator_guser_id",
             @"createTime" : @"create_time",
             @"creator" : @"creatorguser"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"time"]) {
        self.createTime = self.createTime != nil ? self.createTime : oldValue;
    }
    
    return oldValue;
}

@end

@implementation GIMGroupCreator

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id",
             @"avatar" : @"img_face",
             @"nickName" : @"nickname"
             };
}

@end
