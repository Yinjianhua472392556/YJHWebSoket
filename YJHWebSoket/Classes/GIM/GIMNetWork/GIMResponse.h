//
//  GIMResponse.h
//  WebSocket
//
//  Created by  on 2017/5/16.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIMResponse : NSObject

/**
 表示请求成功与否的状态码
 */
@property (nonatomic) NSUInteger code;
/**
 表示请求成功与否的文字描述信息
 */
@property (nonatomic, copy) NSString *message;
/**
 请求成功之后返回的数据
 */
@property (nonatomic, strong) id data;

/**
 表示成功与否的布尔值
 */
@property (nonatomic) BOOL success;

@end
