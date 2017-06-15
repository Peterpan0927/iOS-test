//
//  QQCellTableViewCell.m
//  QQchat
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "QQCell.h"
#import "QQModel.h"
#import "QQFrameModel.h"


@interface QQCell()

@property (nonatomic, weak) UIImageView *userImage;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIButton *contentButton;

@end

@implementation QQCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UILabel *timeLabel = [[UILabel alloc] init];
    
    self.timeLabel = timeLabel;
    //居中显示
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:timeLabel];
    
    UIImageView *userImage = [[UIImageView alloc] init];
    
    self.userImage = userImage;
    
    [self.contentView addSubview:userImage];
    
    UIButton *contentButton = [[UIButton alloc] init];
    
    contentButton.titleLabel.numberOfLines = 0;
    
    self.contentButton = contentButton;
    
    [contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    contentButton.titleLabel.font = [UIFont systemFontOfSize:17];
    //设置button的内边距
    contentButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.contentView addSubview:contentButton];
}

-(void)setFrameModel:(QQFrameModel *)frameModel{
    
    _frameModel = frameModel;
    
    [self setupData];
    
    [self setupFrame];
}

-(void)setupData{
    QQModel *model = _frameModel.qqmodel;
    
    self.timeLabel.text = model.time;
    
    _timeLabel.hidden = model.isHiddenTimeLabel;
    //设置用户头像和背景界面
    if(model.type == QQUsertypeMe){
        //用户头像
        _userImage.image = [UIImage imageNamed:@"other"];
        //对图片进行处理
        UIImage *resizeImage = [self resizeImage:@"chat_send_nor"];
        [_contentButton setBackgroundImage:resizeImage forState:UIControlStateNormal];
    }
    else{
        _userImage.image = [UIImage imageNamed:@"me"];
        UIImage *resizeImage = [self resizeImage:@"chat_recive_press_pic"];
        [_contentButton setBackgroundImage:resizeImage forState:UIControlStateNormal];
    }
    [_contentButton setTitle:model.text forState:UIControlStateNormal];
}

//抽取图片拉伸的方法
-(UIImage *)resizeImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat halfWidth = image.size.width/2;
    
    CGFloat halfHeight = image.size.height/2;
    
    UIImage *resizeImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
    
    return resizeImage;
}

-(void) setupFrame{
    _userImage.frame = _frameModel.iconFrame;
    
    _timeLabel.frame = _frameModel.timeLabelFrame;
    
    _contentButton.frame = _frameModel.textFrame;
}
@end
