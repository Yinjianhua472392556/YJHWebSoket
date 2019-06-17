//
//  GIMPostUserModel.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIMPostUserModel : NSObject

/** 昵称 */
@property (nonatomic, copy) NSString *nickname;

/** 用户的ID */
@property (nonatomic, copy) NSString *ID;

/** 用户头像 */
@property (nonatomic, copy) NSString *avatar;

/** 城市 */
@property (nonatomic, copy) NSString *location;

@end
