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
@property (strong, nonatomic) NSArray *pictures;


@end

@implementation ViewController

- (void)viewDidLoad {
    //当控制器的view和上面的子控件创建完毕之后就会执行这个方法
    [super viewDidLoad];
    NSDictionary *dict1 = @{@"icon":@"1.jpeg",@"info":@"1/3",@"index":@"唔哈哈哈哈哈哈哈"};
    NSDictionary *dict2 = @{@"icon":@"2.jpg",@"info":@"2/3",@"index":@"小朋友们还记得我吗？我就是光头"};
    NSDictionary *dict3 = @{@"icon":@"3.jpg",@"info":@"3/3",@"index":@"紫薇，站住不许走"};
    self.pictures = @[dict1, dict2, dict3];
    self.index = 1;
    self.lastbutton.enabled = NO;
    [self changeImage];
}

- (IBAction)LastButton:(UIButton *)sender {
    self.index--;
    [self changeImage];
}
- (IBAction)NextButton:(UIButton *)sender {
    self.index++;
    [self changeImage];
   }

- (void)changeImage{
    NSDictionary *dict = self.pictures[self.index-1];
    self.infoLabel.text = dict[@"info"];
    self.indexLabel.text = dict[@"index"];
    self.imageview.image = [UIImage imageNamed:dict[@"icon"]];
    self.lastbutton.enabled = (self.index==1)?NO:YES;
    self.nextbutton.enabled = (self.index==3)?NO:YES;
    }

@end
