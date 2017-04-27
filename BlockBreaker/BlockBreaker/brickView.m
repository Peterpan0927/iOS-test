//
//  brickView.m
//  BlockBreaker
//
//  Created by Mac on 2017/4/26.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "brickView.h"
@implementation brickView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    startLocation=[[touches anyObject] locationInView:self];
    
    [[self superview] bringSubviewToFront:self];
}
//实时改变自身坐标
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    CGPoint point=[[touches anyObject] locationInView:self];
    CGRect frame=self.frame;
    
    
    frame.origin.x = frame.origin.x + (point.x-startLocation.x);
    
    self.frame=frame;
}
@end
