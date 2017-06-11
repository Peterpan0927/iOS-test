//
//  ViewController.m
//  simpleWeibo
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "WeiboModel.h"
#import "WeiboViewCell.h"
#import "ContentFrameModel.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

-(NSArray *)dataArray{
    if(nil == _dataArray){
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"weibo.plist" ofType:nil];
        
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *mutabel = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dict in tempArray){
            WeiboModel *model = [WeiboModel weiboWithDict:dict];
            ContentFrameModel *frameModel = [[ContentFrameModel alloc] init];
            frameModel.weiboModel = model;
            [mutabel addObject:frameModel];
        }
        _dataArray = mutabel;
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 450;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"hhh";
    
    WeiboViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(nil == cell){
        cell = [[WeiboViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    ContentFrameModel *contentFrameModel = self.dataArray[indexPath.row];
    
    cell.contentFrameModel = contentFrameModel;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentFrameModel *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

@end
