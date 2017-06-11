//
//  ViewController.m
//  test6
//
//  Created by Mac on 2017/4/26.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "CarModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        
        _dataArray = [NSMutableArray array];
        // 1. 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_simple.plist" ofType:nil];
        
        // 2. 读取文件内容到临时数组中
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3. 创建一个可变数组
        //NSMutableArray *mutabl = [NSMutableArray array];
        
        // 4. 字典转模型， 并装入可变数组中
        for (NSDictionary *dict in tempArray) {
            CarModel *model = [CarModel carModelWithDict:dict];
            
            [_dataArray addObject:model];
        }
        
        // 5. 把可变数组赋值给 dataArray
        
        //_dataArray = mutabl;
    }
       return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    //_tableView.editing = YES;
    }

// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 首先, 把组索引对应到数组中的carModel对象给取出来
    // 1. 先取出在数组中对应的model
    CarModel *carModel = self.dataArray[section];
    
    // 2. 取出carModel中的 cars 数组 --》 决定了这一组显示的行数
    NSArray *cars = carModel.cars;
    
    return cars.count;
}


// 每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 实例化cell
    static NSString *indentifier = @"heroCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if(nil == cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    // 取出model
    CarModel *model = self.dataArray[indexPath.section];
   

    // cars 包含了整个组中所有行要显示的数据
    NSArray *carArray = model.cars;
    
    cell.textLabel.text = carArray[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark -  设置组头部文本
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // 取出model
    CarModel *model = self.dataArray[section];
    
    return model.title;
}


#pragma mark -
#pragma mark -  设置组尾部文本
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // 取出model
    CarModel *model = self.dataArray[section];
    
    return model.desc;
}
//当cell被选中的时候就会被调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarModel *model = self.dataArray[indexPath.row];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"编辑" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //显示输入框
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextView *textField = [alertView textFieldAtIndex:0];
    textField.text = model.title;
    alertView.tag = indexPath.row;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) { // 点击了确定按钮
        /**
         修改数据显示， 修改英雄的名字
         */
        
        // 取出 alertView中的文本输入框
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        // 修改过之后的名字
        NSString *newName = textField.text;
        
        // 修改数据源中 的 英雄名字
        // 取出alertView 的tag , 点击的某个行
        NSInteger index = alertView.tag;
        
        // 取出点击行所对应的 数据源中的模型
        CarModel *model = self.dataArray[index];
        
        NSArray *carArray = model.cars;
        
        carArray[index] = newName;
        // 刷新tableView中的数据, 对所有数据进行刷新
         //       [_tableView reloadData];
        
        
        // 对某一行cell的数据进行刷新
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
    }
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
