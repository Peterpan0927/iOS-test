//
//  layer.h
//  猜拳游戏
//
//  Created by Mac on 2017/3/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

@interface Player: NSObject
{
    @public
    NSString *_name;
    int _score;
    pzptype _selectedtype;
}

-(NSString *)change:(int)number;
-(void)showfist;

@end
