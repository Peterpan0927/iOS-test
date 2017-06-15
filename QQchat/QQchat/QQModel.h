//
//  QQModel.h
//  QQchat
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,QQUsertype){
    QQUsertypeOther,
    QQUsertypeMe,
};

@interface QQModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) QQUsertype type;
//记录timeLabel中的cell是否需要隐藏掉
@property (nonatomic, assign, getter=isHiddenTimeLabel) BOOL hiddenTimeLabel;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)qqModelWithDict:(NSDictionary *)dict;

@end
