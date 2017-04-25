//
//  robot.m
//  猜拳游戏
//
//  Created by Mac on 2017/3/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "robot.h"

@implementation Robot

-(void)showfist{
    int selectedrobot = arc4random_uniform(3) + 1;
    NSString *result = [self change:selectedrobot];
    NSLog(@"机器人%@出的拳头是%@",_name,result);
    _selectedtype = selectedrobot;
}

-(NSString*)change:(int)number{
    switch (number) {
        case 1:
            return @"剪刀";
            break;
        case 2:
            return @"石头";
        case 3:
            return @"布";
        default:NSLog(@"Please input the right number");
            return 0;
    }
}

@end
