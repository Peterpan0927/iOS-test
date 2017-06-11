//
//  WeiboModel.h
//  simpleWeibo
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboModel : NSObject

// 表示文本内容
@property (nonatomic, copy) NSString *text;

// 表示头像
@property (nonatomic, copy) NSString *icon;

// 表示配图
@property (nonatomic, copy) NSString *picture;

// 用户名称
@property (nonatomic, copy) NSString *name;

// 表示是否是vip ， 1 表示 是
@property (nonatomic, assign) NSInteger vip;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)weiboWithDict:(NSDictionary *)dict;

@end
