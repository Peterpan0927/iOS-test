//
//  robot.h
//  猜拳游戏
//
//  Created by Mac on 2017/3/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
@interface Robot : NSObject
{
    @public
    NSString *_name;
    int _score;
    pzptype _selectedtype;
}
-(void)showfist;
-(NSString *)change:(int)number;
@end
