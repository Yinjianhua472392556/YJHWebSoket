//
//  GIMPostUserModel.m
//  WebSocket
//
//  Created by  on 2017/5/17.
//  Copyright © 2017年 G-mall. All rights reserved.
//

#import "GIMPostUserModel.h"
#import "MJExtension.h"

@implementation GIMPostUserModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"ID" : @"id",
             @"avatar" : @"img_face"
             };
}

@end
