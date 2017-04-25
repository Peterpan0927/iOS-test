//
//  judger.m
//  猜拳游戏
//
//  Created by Mac on 2017/3/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "judger.h"

@implementation judger
-(void)judge:(Player *)player with:(Robot *)robot{
    pzptype playerselected = player->_selectedtype;
    pzptype robotselected = robot->_selectedtype;
    int  res = playerselected > robotselected;
    if(res&&(playerselected-robotselected!=2))
    {
        NSLog(@"%@赢了，积一分",player->_name);
        player->_score++;
    }
    else if(playerselected == robotselected)
    {
        NSLog(@"你们真是心有灵犀啊！");
    }
    else
    {
        NSLog(@"机器人%@赢了，积一分",robot->_name);
        robot->_score++;
    }
    NSLog(@"%@的分数是%d,机器人%@的分数是%d",player->_name,player->_score,robot->_name,robot->_score);
}
@end
