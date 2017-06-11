//
//  GroupsonsModel.h
//  Weibo
//
//  Created by Mac on 2017/6/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupsonsModel : NSObject
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *buyCount;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)groupsonsModelWithDict:(NSDictionary *)dict;
@end
