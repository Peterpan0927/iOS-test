//
//  judger.h
//  猜拳游戏
//
//  Created by Mac on 2017/3/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "robot.h"
#import "Player.h"
@interface judger : NSObject
{
    @public
    NSString *_name;
}
-(void)judge:(Player *)player with:(Robot *)robot;


@end
