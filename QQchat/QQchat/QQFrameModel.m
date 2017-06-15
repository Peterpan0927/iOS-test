//
//  QQFrameModel.m
//  QQchat
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQFrameModel.h"
#import "QQModel.h"

//屏幕的宽高
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kDeltamargin 40

@implementation QQFrameModel

-(void)setQqmodel:(QQModel *)qqmodel{
    _qqmodel = qqmodel;
    
    CGFloat timeLabelX = 0;
    CGFloat timeLabelY = 0;
    CGFloat timeLabelWidth = kScreenSize.width;
    CGFloat timeLabelHeight = 20;

    _timeLabelFrame = CGRectMake(timeLabelX, timeLabelY, timeLabelWidth, timeLabelHeight);
    
    CGFloat margin = 10;
    CGFloat iconX = margin;
    CGFloat iconY = CGRectGetMaxY(_timeLabelFrame) + margin;
    CGFloat iconWidth = 40;
    CGFloat iconHeight = 40;

    if(qqmodel.type == QQUsertypeOther){
        _iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    }else{
        _iconFrame = CGRectMake(kScreenSize.width - margin - iconWidth, iconY, iconWidth, iconHeight);
    }
    //计算文本的frame
    CGFloat maxWidth = kScreenSize.width - 2 * margin -2 * iconWidth;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17]} ;
    
    CGSize textRealSize = [qqmodel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    CGFloat textX = CGRectGetMaxX(_iconFrame);
    CGFloat textY = iconHeight;
    //判断左右
    if(qqmodel.type == QQUsertypeOther){
        _textFrame = CGRectMake(textX, textY-10, textRealSize.width, textRealSize.height);
    }else{
        CGFloat rightTextWidth = kScreenSize.width - margin - iconWidth - textRealSize.width - kDeltamargin;
        _textFrame = CGRectMake(rightTextWidth, textY-10, textRealSize.width, textRealSize.height);
    }
    
    _textFrame.size.width += kDeltamargin;
    _textFrame.size.height += kDeltamargin;
    
    _cellHeight = CGRectGetMaxY(_textFrame) + margin;
    
    
}

@end
