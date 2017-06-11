//
//  WeiboModel.m
//  simpleWeibo
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)weiboWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
