//
//  CarModel.h
//  test6
//
//  Created by Mac on 2017/6/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSArray *cars;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)carModelWithDict:(NSDictionary *)dict;
@end
