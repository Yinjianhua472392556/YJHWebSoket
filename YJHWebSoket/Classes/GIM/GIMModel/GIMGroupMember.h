//
//  GIMGroupMember.h
//  WebSocket
//
//  Created by  on 2017/5/28.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIMGroupMember : NSObject

/**
 用户ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 昵称
 */
@property (nonatomic, copy) NSString *nick;

/**
 头像
 */
@property (nonatomic, copy) NSString *avatar;

@end
