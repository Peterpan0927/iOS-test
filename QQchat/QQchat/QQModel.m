//
//  QQModel.m
//  QQchat
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQModel.h"

@implementation QQModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)qqModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
