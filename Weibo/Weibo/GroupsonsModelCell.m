//
//  GroupsonsModelCell.m
//  Weibo
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "GroupsonsModelCell.h"
#import "GroupsonsModel.h"

@interface GroupsonsModelCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation GroupsonsModelCell
- (void)awakeFromNib {
    // Initialization code
    NSLog(@"awakeFromNib");
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame");
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"initWithStyle");
    }
    return self;
}

- (void)setGrouponsModel:(GroupsonsModel *)grouponsModel{
    _grouponsModel = grouponsModel;
    //_iconImageView = grouponsModel.icon;
    _nameLabel.text = grouponsModel.title;
    _priceLabel.text = [NSString stringWithFormat:@"$%@",grouponsModel.price ];
    _buyCountLabel.text = [NSString stringWithFormat:@"已卖出：%@", grouponsModel.buyCount ];
    
}

@end
