//
//  NewInputsViewController.m
//  农产品拍易传App
//
//  Created by 潘振鹏 on 2017/9/13.
//  Copyright © 2017年 潘振鹏. All rights reserved.
//

#import "NewInputsViewController.h"
#import "underLine.h"

@interface NewInputsViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet underLine *inputsName;

@property (weak, nonatomic) IBOutlet underLine *manufacturerName;

@property (weak, nonatomic) IBOutlet underLine *safetyInterval;

@property (weak, nonatomic) IBOutlet underLine *useNumber;

@property (weak, nonatomic) IBOutlet underLine *company;

@property (nonatomic, strong) NSArray *dataArray0;

@property (nonatomic, strong) NSArray *dataArray1;

@property (nonatomic, strong) NSArray *dataArray2;

@property (nonatomic, strong) NSArray *dataArray3;

@property (nonatomic, strong) UIToolbar *toolbar;

@property (nonatomic, strong) UIPickerView *pickerView0;

@property (nonatomic, strong) UIPickerView *pickerView1;

@property (nonatomic, strong) UIPickerView *pickerView2;

@property (nonatomic, strong) UIPickerView *pickerView3;

@end

@implementation NewInputsViewController
- (IBAction)photoBtnClick:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //相机
            UIImagePickerController *imagePickerController =  [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:^{}];
            
        }];
        [alertController addAction:defaultAction];
    }
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //相册
        UIImagePickerController *imagePickerController =  [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];
    [alertController addAction:defaultAction1];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1004];
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [button setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];//如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    
    //裁成边角
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setborder:self.submitBtn WithRedis:6 AndBorderWidth:0 AndBorderColor: [UIColor greenColor]];
    [self setUIField];
            // Do any additional setup after loading the view.
}


- (void)setUIField{
    [self setRightViewWithTextField:self.inputsName imageName:@"tubiao"];
    [self setRightViewWithTextField:self.manufacturerName imageName:@"tubiao"];
    [self setRightViewWithTextField:self.safetyInterval imageName:@"tubiao"];
    [self setRightViewWithTextField:self.useNumber imageName:@"tubiao"];
    [self setRightViewWithTextField:self.company imageName:@"tubiao"];

    self.inputsName.inputView = self.pickerView0;
    self.inputsName.inputAccessoryView = self.toolbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setborder:(UIButton *)btn WithRedis:(int)redis AndBorderWidth:(CGFloat)width AndBorderColor:(UIColor *)color{
    //设置圆角的半径
    [btn.layer setCornerRadius:redis];
    //切割超出圆角范围的子视图
    btn.layer.masksToBounds = YES;
    //设置边框的颜色
    [btn.layer setBorderColor:color.CGColor];
    //设置边框的粗细
    [btn.layer setBorderWidth:width];
}


-(void)setRightViewWithTextField:(UITextField *)textField imageName:(NSString *)imageName{
    
    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 40)];
    rightView.image = [UIImage imageNamed:imageName];
    rightView.contentMode = UIViewContentModeCenter;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        return self.dataArray0.count;
    }else if(pickerView.tag == 1){
        return self.dataArray1.count;
    }else if(pickerView.tag == 2){
        return self.dataArray3.count;
    }
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *group = [NSArray array];
    if(pickerView.tag == 0){
        group = self.dataArray0;
        return group[row];
    }else if(pickerView.tag == 1){
        group = self.dataArray1;
        return group[row];
    }else if (pickerView.tag == 2){
        group = self.dataArray3;
        return group[row];
    }
    return group[row];
}

- (UIPickerView *)pickerView0{
    if(_pickerView0 == nil){
        _pickerView0 = [[UIPickerView alloc] init];
        _pickerView0.tag = 0;
        self.pickerView0.delegate = self;
        self.pickerView0.dataSource = self;
    }
    return _pickerView0;
}

- (UIPickerView *)pickerView1{
    if(_pickerView1 == nil){
        _pickerView1 = [[UIPickerView alloc] init];
        _pickerView1.tag = 0;
        self.pickerView1.delegate = self;
        self.pickerView1.dataSource = self;
    }
    return _pickerView1;
}

- (UIPickerView *)pickerView2{
    if(_pickerView2 == nil){
        _pickerView2 = [[UIPickerView alloc] init];
        _pickerView2.tag = 0;
        self.pickerView2.delegate = self;
        self.pickerView2.dataSource = self;
    }
    return _pickerView2;
}

- (UIPickerView *)pickerView3{
    if(_pickerView3 == nil){
        _pickerView3 = [[UIPickerView alloc] init];
        _pickerView3.tag = 0;
        self.pickerView3.delegate = self;
        self.pickerView3.dataSource = self;
    }
    return _pickerView3;
}

- (UIToolbar *)toolbar{
    if(_toolbar == nil){
        _toolbar = [[UIToolbar alloc] init];
        _toolbar.frame = CGRectMake(0, 0, 0, 44);
        //按钮，取消 弹簧 完成
        //常用的创建方式
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
        //系统类型
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //自定义View
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
        _toolbar.items = @[cancel, flexSpace, done];
    }
    
    return _toolbar;
}


- (NSArray *)dataArray0{
    if(_dataArray0 == nil){
        _dataArray0 = @[@"沼液", @"菜籽饼"];
    }
    return _dataArray0;
}

- (void)btnClick{
    
}

- (void)cancelClick{
    
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
