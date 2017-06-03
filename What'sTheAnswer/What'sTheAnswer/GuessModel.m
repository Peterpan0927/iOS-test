//
//  GuessModel.m
//  What'sTheAnswer
//
//  Created by Mac on 2017/5/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "GuessModel.h"

@implementation GuessModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        //kvc实现字典的快速赋值
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)guessModelDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
