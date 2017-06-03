//
//  ViewController.m
//  test7
//
//  Created by Mac on 2017/5/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 0.3;
    //设置成为代理
    _scrollView.delegate = self;
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
//当scrollView滚动的时候就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滚动时调用");
}
//开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"开始拖拽");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"停止拖拽");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"Zooming");
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    NSLog(@"begin zooming");
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"end zooming");
}
@end
