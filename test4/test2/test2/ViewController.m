//
//  ViewController.m
//  test2
//
//  Created by Mac on 2017/4/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic)IBOutlet UIView *whiteview;
@end

@implementation ViewController
//修改父控件View的颜色
- (IBAction)changeFatherViewColor:(UIButton *)sender{
    UIView *fatherview = sender.superview;
    float randomR = arc4random_uniform(255)/255.0;
    float randomG = arc4random_uniform(255)/255.0;
    float randomB = arc4random_uniform(255)/255.0;
    UIColor *randomcolor = [UIColor colorWithRed:randomR green:randomG blue:randomB alpha:1];
    fatherview.backgroundColor=randomcolor;
}
-(IBAction)createview:(UIButton *)sender{
    UIView *createview = [ [UIView alloc] init];
    int randomX = arc4random_uniform(200);
    int randomY = arc4random_uniform(190);
    createview.frame=CGRectMake(randomX, randomY, 40, 40);
    float randomR = arc4random_uniform(255)/255.0;
    float randomG = arc4random_uniform(255)/255.0;
    float randomB = arc4random_uniform(255)/255.0;
    UIColor *randomcolor = [UIColor colorWithRed:randomR green:randomG blue:randomB alpha:1];
    createview.backgroundColor=randomcolor;
    [self.whiteview addSubview:createview];
    CGRect oldFrame = createview.frame;
    oldFrame.origin.x = arc4random_uniform(190);
    oldFrame.origin.y = arc4random_uniform(190);
    [UIView animateWithDuration:1 animations:^{
        createview.frame = oldFrame;
    }];

    
}


@end
