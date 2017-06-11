//
//  FooterView.h
//  Weibo
//
//  Created by Mac on 2017/6/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FooterView;

@protocol FooterViewDelegate <NSObject>

- (void)footerView:(FooterView *)footerView;

@end


@interface FooterView : UIView

@property (nonatomic, weak) id<FooterViewDelegate> delegate;

- (void)showLoadViewWith:(BOOL)isShow;

@end
