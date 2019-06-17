//
//  GIMTextMessageBody.h
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMMessageContent.h"

@interface GIMTextMessageContent : GIMMessageContent

/**
 消息文本的内容
 */
@property (nonatomic, copy) NSString *text;

/**
 初始化content模型
 
 @param text GIMTextMessageContent的text属性
 @return GIMTextMessageContent模型
 */
- (instancetype)initWithText:(NSString *)text;

@end
