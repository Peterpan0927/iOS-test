//
//  layer.m
//  猜拳游戏
//
//  Created by Mac on 2017/3/23.
//  Copyright © 2017年 Mac. All rights reserved.
//
#import "Player.h"

@implementation Player

-(void)showfist{
    NSLog(@"Please input your choice: 1.剪刀 2.石头 3.布");
    int kind  = 0;
    scanf("%d",&kind);
    NSString *result = [self change:kind];
    NSLog(@"玩家%@ ,你选择了%@",_name,result);
    _selectedtype = kind;
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
        default:NSLog(@"小伙子不乖哦");
    }
    return @"作弊";
}

@end
