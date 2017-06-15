//
//  Person.m
//  通知测试
//
//  Created by Mac on 2017/6/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "Person.h"
#import "Company.h"
@implementation Person
-(void)recieveNotification:(NSNotification *)noti{
    //取出userInfo
    NSDictionary *dict = noti.userInfo;
    //取出公司信息
    Company *company = dict[@"company"];
    
    NSLog(@"%@,订阅了%@, %@ 更新了",self.name, company.companyName, company.movieName);
}

#warning 3.移除监听
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
