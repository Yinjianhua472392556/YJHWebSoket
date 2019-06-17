//
//  GIMSocialGroup.h
//  WebSocket
//
//  Created by  on 2017/6/12.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIMSocialGroup : NSObject

/**
 社群ID
 */
@property (nonatomic, copy) NSString *ID;

/**
 社群标题
 */
@property (nonatomic, copy) NSString *title;

/**
 话题ID
 */
@property (nonatomic, copy) NSString *topicID;

@end
