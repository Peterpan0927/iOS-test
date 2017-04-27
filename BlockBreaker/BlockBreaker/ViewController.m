//
//  ViewController.m
//  BlockBreaker
//
//  Created by Mac on 2017/4/25.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "brickView.h"

#define BRICKHIGHT 15
#define BRICKWIDTH 44
#define TOP 40
#define BOARDHIGHT 10
#define BOARDWIDTH 48

#define WIDTH (self.view.frame.size.width)
#define NUM ((NSInteger)(self.view.frame.size.width-20)/53)

@interface ViewController ()
@property(nonatomic,assign)CGPoint moveDis;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)brickView * board;
@property(nonatomic,strong)UIImageView *ball;
@property(nonatomic,assign)double speed;
@property(nonatomic,strong)NSMutableArray *bricks;
@property(nonatomic,assign)NSInteger numOfBricks;
@property (weak, nonatomic)IBOutlet UIButton *startBtn;

@end

@implementation ViewController
- (void)pause{
    self.timer.fireDate=[NSDate distantFuture];
}
//重写setter方法
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:_speed target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        _timer.fireDate=[NSDate distantFuture];
    }
    
    return _timer;
}
//通过设置使highlighted不会被清除
- (void)highlightButton:(UIButton *)b {
    [b setHighlighted:YES];
}

- (IBAction)onTouchup:(UIButton *)sender {
    [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
}
- (IBAction)startBtnClick:(id)sender {
    _startBtn.selected=!_startBtn.selected;
    
    if (!_startBtn.selected) {
        [self pause];
    }
    else{
        if (!_timer) {
            [self timer];
            self.ball.frame=CGRectMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0-20, 20, 20);
            [self.view addSubview:_ball];
            _board.frame=CGRectMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0, BOARDWIDTH, BOARDHIGHT);
        }
        _timer.fireDate=[NSDate dateWithTimeIntervalSinceNow:0];
    }

}
-(brickView *)board{
    if (!_board) {
        _board=[[brickView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
        //定义图像的用户交互作用属性值
        [_board setUserInteractionEnabled:YES];
        //定义弹板的坐标，尺寸
        _board.frame=CGRectMake(self.view.frame.size.width/2.0-15, self.view.frame.size.height/2.0, BOARDWIDTH, BOARDHIGHT);
        [self.view addSubview:_board];
    }
    return _board;
}
-(void)viewDidLoad{
    [super viewDidLoad];
     UIImageView *brick;
    _moveDis=CGPointMake(-3, -3);
    _speed=0.02;
    [self board];
    _ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.png"]];
    [self brickNum:brick];
}
-(void)brickNum:(UIImageView *)brick{
    
    self.bricks=[NSMutableArray arrayWithCapacity:4*NUM];
    _speed-=0.003;
    self.numOfBricks=4*NUM;
    
    for (int i=0; i<4; i++) {
        
        for (int j=0;j<NUM;j++) {
            
            brick=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
            brick.frame=CGRectMake(40+j*BRICKWIDTH+j*5, TOP+10+BRICKHIGHT*i+5*i, BRICKWIDTH, BRICKHIGHT);
            [self.view addSubview:brick];
            [self.bricks addObject:brick];
        }
    }
}
-(void)onTimer{
    float posx,posy;
    //球的中心坐标
    posx=self.ball.center.x;
    posy=self.ball.center.y;
    self.ball.center = CGPointMake(posx+self.moveDis.x, posy+self.moveDis.y);
    //球边界限制
    if (self.ball.center.x>WIDTH || self.ball.center.x<0 ) {
        _moveDis.x=-self.moveDis.x;
    }
    
    if ( _ball.center.y<TOP ) {
        _moveDis.y=-_moveDis.y;
    }
    NSInteger j=[_bricks count];
    for (int i=0; i<j; i++) {
        UIImageView *brick=(UIImageView *)[_bricks objectAtIndex:i];
        if (CGRectIntersectsRect(_ball.frame, brick.frame)&&[brick superview]) {
            [brick removeFromSuperview];
            _numOfBricks--;
            if ((_ball.center.y-16<brick.frame.origin.y+BRICKHIGHT || _ball.center.y+16>brick.frame.origin.y)
                && _ball.center.x>brick.frame.origin.x && _ball.center.x<brick.frame.origin.x+BRICKWIDTH) {
                _moveDis.y=-_moveDis.y;
            }else if (_ball.center.y>brick.frame.origin.y && _ball.center.y<brick.frame.origin.y+BRICKHIGHT
                      && (_ball.center.x+16>brick.frame.origin.x || _ball.center.x-16<brick.frame.origin.x+BRICKWIDTH)){
                _moveDis.x=-_moveDis.x;
            }else{
                _moveDis.x=-_moveDis.x;
                _moveDis.y=-_moveDis.y;
            }
            break;
        }
    }
    if(_numOfBricks==0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"K.O." message:@"恭喜你赢了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"再来一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageView *brick;
            [self brickNum:brick];
            _startBtn.selected=!_startBtn.selected;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
         [self presentViewController:alert animated:YES completion:nil];
    }
    if (CGRectIntersectsRect(_ball.frame, _board.frame)) {
        if (_ball.center.x>_board.frame.origin.x&&_ball.center.x<_board.frame.origin.x+BOARDWIDTH) {
            _moveDis.y=-_moveDis.y;
        }else {
            _moveDis.x=-_moveDis.x;
            _moveDis.y=-_moveDis.y;
        }
    }else{
        if (_ball.center.y>_board.center.y){
            [_ball removeFromSuperview];
            [_timer invalidate];
            _timer=NULL;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"你输了" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"再来一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImageView *brick;
                for (brick in _bricks){
                    [brick removeFromSuperview];
                }
                [self brickNum:brick];
                _startBtn.selected=!_startBtn.selected;
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
 }
}

@end
