//
//  GroupsonsModel.m
//  Weibo
//
//  Created by Mac on 2017/6/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "GroupsonsModel.h"

@implementation GroupsonsModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self == [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}
+(instancetype)groupsonsModelWithDict:(NSDictionary *)dict{
    return  [[self alloc]initWithDict:dict];
}
@end
