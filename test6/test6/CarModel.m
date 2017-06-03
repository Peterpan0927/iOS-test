//
//  CarModel.m
//  test6
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel 
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)carModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
