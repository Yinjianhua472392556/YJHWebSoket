//
//  GIMVideoMessageContent.h
//  SuperGone
//
//  Created by  on 2017/8/14.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"
#import <UIKit/UIKit.h>

@interface GIMVideoMessageContent : GIMMessageContent

/**
 视频封面的地址
 */
@property (nonatomic, copy) NSString *cover;

/**
 视频的链接
 */
@property (nonatomic, copy) NSString *url;

/* 本地地址 */
@property (nonatomic, strong) NSString *localAdress;

/* 本地截图 */
@property (nonatomic, strong) UIImage *localImage;


/* 本地的截图 */
//@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithChatType:(GIMConversationType)conversationType;

@end
