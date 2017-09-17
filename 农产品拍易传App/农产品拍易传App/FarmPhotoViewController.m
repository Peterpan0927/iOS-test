//
//  FarmPhotoViewController.m
//  农产品拍易传App
//
//  Created by 潘振鹏 on 2017/9/7.
//  Copyright © 2017年 潘振鹏. All rights reserved.
//

#import "FarmPhotoViewController.h"
#import "DrawerViewController.h"
#import "LoginViewController.h"
#import "NewFarmPhotoViewController.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width

#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface FarmPhotoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FarmPhotoViewController

- (IBAction)btnClick{
    [[DrawerViewController sharedDrawer] openLeftMenu];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self addGestureRecognizer];
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.frame = CGRectMake(kScreenW - 80, kScreenH - 80, 60, 60);
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    self.bottomButton.layer.cornerRadius = self.bottomButton.frame.size.width/2;
    self.bottomButton.layer.masksToBounds = YES;
    [self.view addSubview:self.bottomButton];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *view = [[UIView alloc] init];
    [[DrawerViewController sharedDrawer] addScreenEdgePanGestureRecognizerToView:view];
    // Do any additional setup after loading the view.
}

- (void)add{
   [self performSegueWithIdentifier:@"new" sender:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)addGestureRecognizer {
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGRAction:)];
    
    longPressGR.minimumPressDuration = 1.0; // 设置最短长按的时间
    [self.tableView addGestureRecognizer:longPressGR];
}

- (void)longPressGRAction:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint pressPoint = [sender locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:pressPoint];
        
        if (indexPath == nil) {
            return;
        }
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除此条农事活动" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"indexPath.row = %ld",indexPath.row);
            
            // 删除数据
            [self deleteOrderWithIndexPath:indexPath];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertViewController addAction:okAction];
        [alertViewController addAction:cancleAction];
        
        [self presentViewController:alertViewController animated:YES completion:nil];
    }
}

-(void)deleteOrderWithIndexPath:(NSIndexPath *)indexPath {
    
    // 删除数据对应的数据源
    [self.dataArray removeObjectAtIndex:indexPath.row];
    // 删除行
    NSArray *pathArray = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:pathArray withRowAnimation:UITableViewRowAnimationFade];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
