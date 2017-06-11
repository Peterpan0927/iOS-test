//
//  BannerView.m
//  Weibo
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BannerView.h"
#define kScrollViewSize (_scrollView.frame.size)
@interface BannerView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@end


@implementation BannerView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self setupScrollView];
        
        [self setupPageController];
   
    }
    
    return self;

}

- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    
    self.scrollView = scrollView;
    
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:scrollView];
}

- (void)setupPageController{
    CGSize bannerViewSize = self.bounds.size;
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, bannerViewSize.width/2, 20)];
    
    self.pageControl = pageControl;
    
    pageControl.center = CGPointMake(bannerViewSize.width/2, bannerViewSize.height*0.9) ;
    
    pageControl.currentPageIndicatorTintColor = [UIColor  blackColor];
    
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    pageControl.currentPage = 3;
    
    [self addSubview:pageControl];
    
}

- (void)setImageArray:(NSArray *)imageArray{
    CGSize bannerViewSize = self.bounds.size;
    
    NSInteger count = imageArray.count;
    
    for( int i = 0 ; i < count ; i++ ){
        
        NSString *imageName = imageArray[i];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*bannerViewSize.width, 0, bannerViewSize.width, bannerViewSize.height)];
        
        imageView.image = [UIImage imageNamed:imageName];
        
        [_scrollView addSubview:imageView];
    }
        _scrollView.contentSize = CGSizeMake(count*bannerViewSize.width, 0);
        
        _pageControl.numberOfPages = count;
    
        
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滚动时调用");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // currentPage = scrollView.contentOffset.x / kScrollViewSize.width
    
    _pageControl.currentPage = scrollView.contentOffset.x / kScrollViewSize.width;
}
@end
