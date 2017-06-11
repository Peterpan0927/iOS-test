//
//  FooterView.m
//  Weibo
//
//  Created by Mac on 2017/6/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "FooterView.h"
@interface FooterView()

@property (nonatomic, weak) IBOutlet UIView *loadMoreView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end



@implementation FooterView

- (IBAction)didClickButton:(id)sender{
    if([self.delegate respondsToSelector:@selector(footerView:)]){
        [self.delegate footerView:self];
    }
}

- (void)showLoadViewWith:(BOOL)isShow{
    _loadMoreView.alpha = isShow;
    if(isShow)
        [_activityView startAnimating];
    else
        [_activityView stopAnimating];
}
@end
