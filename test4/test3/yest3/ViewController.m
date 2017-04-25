//
//  ViewController.m
//  yest3
//
//  Created by Mac on 2017/4/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end


@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 200, 100, 100);
    [btn setTitle:@"dsadasc" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(haha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)haha{
    NSLog(@"sadmadmsa");
}



-(IBAction)createButton:(id)sender{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"傻逼" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"11"];
    UIImage *image2 = [UIImage imageNamed:@"22"];
    [btn2 setTitle:@"去死吧" forState:UIControlStateHighlighted];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setBackgroundImage:image2 forState:UIControlStateHighlighted];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn2];
    [self.view addSubview:btn];
}


@end
