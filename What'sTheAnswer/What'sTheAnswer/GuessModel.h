//
//  GuessModel.h
//  What'sTheAnswer
//
//  Created by Mac on 2017/5/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuessModel : NSObject
@property (nonatomic, copy)NSString *answer;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSArray *options;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)guessModelDict:(NSDictionary *)dict;
@end
