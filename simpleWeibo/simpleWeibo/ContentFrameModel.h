//
//  ContentFrameModel.h
//  simpleWeibo
//
//  Created by Mac on 2017/6/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WeiboModel;

@interface ContentFrameModel : NSObject

@property (nonatomic, assign,readonly) CGRect userImageFrame;

@property (nonatomic ,assign,readonly) CGRect vipImageFrame;

@property (nonatomic, assign,readonly) CGRect userNameFrame;

@property (nonatomic, assign,readonly) CGRect contentFrame;

@property (nonatomic, assign,readonly) CGRect pictureImageFrame;

@property (nonatomic, assign,readonly) CGFloat cellHeight;

// 只有拿到数据， 才能对每一个控件的frame进行计算
@property (nonatomic, strong) WeiboModel *weiboModel;

@end
