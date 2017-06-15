//
//  ViewController.m
//  QQchat
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "QQModel.h"
#import "QQFrameModel.h"
#import "QQCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController
- (NSMutableArray *)dataArray{
    if(nil == _dataArray){
        _dataArray = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        
        NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        for(NSDictionary *dict in tempArray){
            
            QQModel *model = [QQModel qqModelWithDict:dict];
            
            QQFrameModel *lastFrameModel = self.dataArray.lastObject;
            
            if([model.time isEqualToString:lastFrameModel.qqmodel.time]){
                model.hiddenTimeLabel = YES;
            }
            
            QQFrameModel *frameModel = [[QQFrameModel alloc] init];
            
            frameModel.qqmodel = model;
            
            [_dataArray addObject:frameModel];
        }
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabelView.dataSource = self;
    
    _tabelView.delegate = self;
    
    _textField.delegate = self;
    
    [self scrollToButtom];
    
    [self registerNotification];
}

- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillAppear:(NSNotification *)noti{
    
    NSDictionary *dict = noti.userInfo;
    
    NSTimeInterval interval = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的高度
    // 停止后的Y值
    CGRect keyboardRect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardEndY = keyboardRect.origin.y;
    
    // 没出现时的Y值
    CGRect tempRect = [dict[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat keyboardBeginY = tempRect.origin.y;
    
    // 对 tableView  执行动画， 向上平移
    [UIView animateWithDuration:interval animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, (keyboardEndY - keyboardBeginY));
    }];

}

- (void)keyboardWillDisappear:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    
    // 间隔时间
    NSTimeInterval interval = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:interval animations:^{
        
        // CGAffineTransformIdentity 恢复 transform的设置
        self.view.transform = CGAffineTransformIdentity;
    }];

}

//当点击键盘右下角的return按钮时就会调用这个方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    static NSInteger x = 1;
    // 撤销 ， textField 的第一响应者身份
    [textField resignFirstResponder];
    //发送自己的消息
    [self sendMessage:textField.text andType:QQUsertypeMe];
    //设置自动回复
    NSString *string = [NSString stringWithFormat:@"这是第%ld次,你是不是傻",x];
    [self sendMessage:string andType:QQUsertypeOther];
    //清空textField中的数据
    textField.text = @"";
    x += 1;
    return YES;
}

- (void)sendMessage:(NSString *)text andType:(QQUsertype)type{
    QQModel *qqmodel = [[QQModel alloc] init];
    //取出当前时间
    NSDate *currentDate = [NSDate date];
    //设置时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"HH:mm";
    
    NSString *dateString = [formatter stringFromDate:currentDate];
    
    qqmodel.time = dateString;
    
    qqmodel.text = text;
    
    qqmodel.type = type;
    
    QQFrameModel *lastFrameModel = self.dataArray.lastObject;
    
    if([qqmodel.time isEqualToString:lastFrameModel.qqmodel.time]){
        qqmodel.hiddenTimeLabel = YES;
    }

    //把qqmodel赋值给qqFrameModel，要根据内容计算控件的frame以及cell的高度
    QQFrameModel *frameModel = [[QQFrameModel alloc] init];
    
    frameModel.qqmodel = qqmodel;
    
    [self.dataArray addObject:frameModel];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    //动画的方式加载新添加的数据
    [_tabelView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //滚动到最后一行
    [_tabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)scrollToButtom{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    
    [_tabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"hello";
    
    QQCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(nil == cell){
        cell = [[QQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    QQFrameModel *frameModel = self.dataArray[indexPath.row];
    
    cell.frameModel = frameModel;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QQFrameModel *frameModel = self.dataArray[indexPath.row];
    
    return frameModel.cellHeight;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return YES;
}

@end
