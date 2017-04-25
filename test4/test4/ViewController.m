//
//  ViewController.m
//  test4
//
//  Created by Mac on 2017/4/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic)IBOutlet UIImageView *imageView;
@end

@implementation ViewController

-(IBAction)moveimage:(UIButton *)sender{
    CGRect oldframe = self.imageView.frame;
    switch (sender.tag) {
        case 1:
            oldframe.origin.x += 10;
            break;
        case 2:
            oldframe.origin.y +=10;
            break;
        case 3:
            oldframe.origin.x -= 10;
            break;
        case 4:
            oldframe.origin.y -= 10;
            break;
        case 5:
            oldframe.size.height += 10;
            oldframe.size.width += 10;
            oldframe.origin.x -= 5;
            oldframe.origin.y -= 5;
            break;
        case 6:
            oldframe.size.height -= 10;
            oldframe.size.width -= 10;
            oldframe.origin.x += 5;
            oldframe.origin.y += 5;
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = oldframe;
    }];
}

-(IBAction)transformimageView:(UIButton *)sender{
    switch(sender.tag){
        case 1:
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_4);
            break;
        case 2:
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, -M_PI_4);
            break;
    }
    
}
@end
