//
//  ViewController.m
//  PhotoViewer
//
//  Created by Mac on 2017/4/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(assign, nonatomic)int index;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *lastbutton;
@property (weak, nonatomic) IBOutlet UIButton *nextbutton;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    //当控制器的view和上面的子控件创建完毕之后就会执行这个方法
    [super viewDidLoad];
    self.index = 1;
    self.lastbutton.enabled = NO;
    [self changeImage];
}

- (IBAction)LastButton:(UIButton *)sender {
    self.index--;
    [self changeImage];
    if (self.index==1)
        sender.enabled = NO;
    if (self.index!=1)
        self.nextbutton.enabled = YES;
}
- (IBAction)NextButton:(UIButton *)sender {
    self.index++;
    [self changeImage];
    if (self.index==3)
        sender.enabled = NO;
    if (self.index!=3)
        self.lastbutton.enabled = YES;
}

- (void)changeImage{
    switch (self.index) {
        case 1:
            self.indexLabel.text = @"唔哈哈哈哈";
            self.infoLabel.text = @"1/3";
            self.imageview.image = [UIImage imageNamed:@"1.jpeg"];
            break;
        case 2:
            self.indexLabel.text = @"小朋友们，还记得我吗？";
            self.infoLabel.text = @"2/3";
            self.imageview.image = [UIImage imageNamed:@"2.jpg"];
            break;
        case 3:
            self.indexLabel.text = @"站住不许走";
            self.infoLabel.text = @"3/3";
            self.imageview.image = [UIImage imageNamed:@"3.jpg"];
            break;
            }
}

@end
