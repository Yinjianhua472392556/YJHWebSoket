//
//  GIMLivingMessagePostContent.m
//  SuperCard
//
//  Created by aa on 2019/1/5.
//  Copyright © 2019 G-mall. All rights reserved.
//

#import "GIMLivingMessagePostContent.h"

@implementation GIMLivingMessagePostContent

@end


@implementation GIMLivingMessageMyPostContent

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"ID" : @"id"
              };
}


@end

@implementation GIMLivingMessageUserContent

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"ID" : @"id"
              };
}

@end

@implementation GIMLivingMessageExtraContent

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"ID" : @"id"
              };
}

@end
