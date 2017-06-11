//
//  ViewController.m
//  Weibo
//
//  Created by Mac on 2017/6/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "GroupsonsModel.h"
#import "GroupsonsModelCell.h"
#import "BannerView.h"
#import "FooterView.h"

@interface ViewController () <UITableViewDataSource,FooterViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation ViewController

-(NSMutableArray *)dataArray{
    if(nil == _dataArray){
        _dataArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"tgs.plist" ofType:nil];
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        for(NSDictionary *dict in tempArray){
            GroupsonsModel *model = [GroupsonsModel groupsonsModelWithDict:dict];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView = tableView;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.rowHeight = 90;
    BannerView *bannerView = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    NSArray *imageArray = @[@"ad_00",@"ad_01",@"ad_02",@"ad_03",@"ad_04"];
    bannerView.imageArray = imageArray;
    bannerView.backgroundColor = [UIColor redColor];
    tableView.tableHeaderView = bannerView;
    FooterView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:nil]lastObject];
    footerView.delegate = self;
    tableView.tableFooterView = footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"123";
    GroupsonsModelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(nil == cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GrouponsCell" owner:nil options:nil] lastObject];
    }
    GroupsonsModel *model = self.dataArray[indexPath.row];
    cell.grouponsModel = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)footerView:(FooterView *)footerView{
    
    [footerView showLoadViewWith:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [footerView showLoadViewWith:NO];
        GroupsonsModel *model = [[GroupsonsModel alloc]init];
        model.title = [NSString stringWithFormat:@"哲学%d",arc4random_uniform(5)];
        model.price = [NSString stringWithFormat:@"%d",arc4random_uniform(34) ];
        model.buyCount = [NSString stringWithFormat:@"%d",arc4random_uniform(678) ];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count inSection:0];
        
        [self.dataArray addObject:model];
        //添加cell，设置动画方式
        [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //使添加一个cell的时候滚动到底部
        [_tableView  scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    });
}



@end
