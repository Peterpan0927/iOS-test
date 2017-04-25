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
//重写getter方法，懒加载
-(NSArray *)pictures{
    if(_pictures == nil)
    {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"imagelist.plist" ofType:nil];
    _pictures = [NSArray arrayWithContentsOfFile:path];
    }
    return _pictures;
}

- (void)viewDidLoad {
    //当控制器的view和上面的子控件创建完毕之后就会执行这个方法
    [super viewDidLoad];
    self.index = 1;
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
    self.nextbutton.enabled = (self.index==self.pictures.count)?NO:YES;
    }

@end
