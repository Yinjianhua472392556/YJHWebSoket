//
//  GIMImageMessageContent.h
//  WebSocket
//
//  Created by  on 2017/5/19.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"
@class UIImage;

@interface GIMImageMessageContent : GIMMessageContent

/**
 上传到网宿之后返回的url
 */
@property (nonatomic, copy) NSString *imageUrl;

/**
 发送图片的时候会有此属性
 */
@property (nonatomic, strong) UIImage *image;

/**
 初始化GIMImageMessageContent
 
 @param image 待发送的图片
 @return 实例化的GIMImageMessageContent模型
 */
- (instancetype)initWithImage:(UIImage *)image;

@end
