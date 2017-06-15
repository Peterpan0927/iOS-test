//
//  main.m
//  通知测试
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Company.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        Company *souhu = [[Company alloc] init];
        souhu.companyName = @"搜狐";
        souhu.movieName = @"全职猎人";
        
        Company *tudou = [[Company alloc] init];
        tudou.companyName = @"土豆";
        tudou.movieName = @"极品家丁";
        
        Person *li = [[Person alloc] init];
        li.name = @"离";
        
        Person *zhangsan = [[Person alloc] init];
        zhangsan.name = @"张三";
        
#warning 1.注册监听
        [[NSNotificationCenter defaultCenter] addObserver:zhangsan selector:@selector(recieveNotification:) name:@"hunter" object:souhu];
        
        [[NSNotificationCenter defaultCenter] addObserver:li selector:@selector(recieveNotification:) name:@"renzhe" object:tudou];
#warning 2.发布通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hunter" object:souhu userInfo:@{@"company":souhu}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"renzhe" object:tudou userInfo:@{@"company":tudou}];
    }
    return 0;
}
