//
//  QQFrameModel.h
//  QQchat
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class QQModel;

@interface QQFrameModel : NSObject

@property (nonatomic, assign) CGRect timeLabelFrame;

@property (nonatomic, assign) CGRect iconFrame;

@property (nonatomic, assign) CGRect textFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) QQModel *qqmodel;

@end
