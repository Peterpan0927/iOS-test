//
//  main.m
//  猜拳游戏
//
//  Created by Mac on 2017/3/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "judger.h"
int main() {
    char y = 'y';
    Player *xiaoming = [Player new];
    xiaoming->_name = @"二营长";
    Robot *alphago = [Robot new];
    alphago->_name = @"alphago";
    judger *judge = [judger new];
    while(y == 'y')
    {
    [xiaoming showfist];
    [alphago showfist];
    [judge judge:xiaoming with:alphago];
    if((xiaoming->_selectedtype>3||xiaoming->_selectedtype<1)&&xiaoming->_score<=alphago->_score)
    {
    NSLog(@"作弊还输，不让你玩了");
          break;
    }
    else if((xiaoming->_selectedtype>3||xiaoming->_selectedtype<1)&&xiaoming->_score>alphago->_score)
    {
        NSLog(@"作弊赢了也没什么好光彩的");
    }
    NSLog(@"小伙子你还玩么？y or n");
    scanf(" %c",&y);
    }
    return 0;
}
