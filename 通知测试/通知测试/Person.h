//
//  Person.h
//  通知测试
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

-(void)recieveNotification:(NSNotification *)noti;

@end
