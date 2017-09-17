//
//  NewFarmPhoto.m
//  农产品拍易传App
//
//  Created by 潘振鹏 on 2017/9/7.
//  Copyright © 2017年 潘振鹏. All rights reserved.
//

#import "NewFarmPhotoViewController.h"
#import "underLine.h"
#import "LoginViewController.h"

#define kBoundary @"boundary"

@interface NewFarmPhotoViewController()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet underLine *framTypeField;

@property (weak, nonatomic) IBOutlet underLine *farmActivityField;

@property (nonatomic, strong) NSArray *dataArray1;

@property (nonatomic, strong) NSArray *dataArray2;

@property (nonatomic, strong) UIPickerView *pickerView1;

@property (nonatomic, strong) UIPickerView *pickerView2;

@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;

@property (nonatomic, strong) UIToolbar *toolbar;
@end


@implementation NewFarmPhotoViewController

- (IBAction)BtnClick:(id)sender {
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
    [button setBackgroundImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];//如果按钮创建时用的是系统风格UIButtonTypeSystem，需要在设置图片一栏设置渲染模式为"使用原图"
    
    //裁成边角
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setborder:self.upLoadBtn WithRedis:6 AndBorderWidth:0.0 AndBorderColor:[UIColor grayColor]];
    self.framTypeField.inputView = self.pickerView1;
    self.framTypeField.inputAccessoryView = self.toolbar;
    [self setRightViewWithTextField:self.framTypeField imageName:@"tubiao"];
    [self setRightViewWithTextField:self.farmActivityField imageName:@"tubiao"];
    self.farmActivityField.inputView = self.pickerView2;
    self.farmActivityField.inputAccessoryView = self.toolbar;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        return  self.dataArray1.count;
    }else return self.dataArray2.count;
}
//返回每一行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //获取每一组的数据
    NSArray *group = [NSArray array];
    if(pickerView.tag == 0) {
        group = self.dataArray1;
    }else{
        group = self.dataArray2;
    }
    return group[row];
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

- (UIPickerView *)pickerView1{
    if(_pickerView1 == nil){
        _pickerView1 = [[UIPickerView alloc] init];
        _pickerView1.tag = 0;
        self.pickerView1.dataSource = self;
        self.pickerView1.delegate = self;
    }
    return _pickerView1;
}

- (UIPickerView *)pickerView2{
    if(_pickerView2 == nil){
        _pickerView2 = [[UIPickerView alloc] init];
        _pickerView2.tag = 1;
        self.pickerView2.dataSource = self;
        self.pickerView2.delegate = self;
    }
    return _pickerView2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *name = [NSString string];
    if(pickerView.tag == 0){
        name = self.dataArray1[row];
        self.framTypeField.text = name;
    }else{
        name = self.dataArray2[row];
        self.farmActivityField.text = name;
    }
}


- (NSArray *)dataArray1{
    if(_dataArray1 == nil){
        _dataArray1 = @[@"种子处理", @"叶子处理", @"作物处理"];
    }
    return _dataArray1;
}

- (NSArray *)dataArray2{
    if(_dataArray2 == nil){
        _dataArray2 = @[@"清洗", @"除草", @"浇水"];
    }
    return _dataArray2;
}

- (void)cancelClick{
    self.farmActivityField.text = @"";
    self.framTypeField.text = @"";
    [self.view endEditing:YES];
}

- (void)btnClick{
    [self.view endEditing:YES];
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
- (IBAction)submitBtnClick:(id)sender {
    //创建请求
    NSURL *url = [NSURL URLWithString:@"http://59.68.29.89:18081/api/1.0/ll/system/photo/uploadPhotoByParams"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    request.HTTPMethod = @"POST";
    //设置请求头部
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;  boundary=%@", kBoundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSString *name = @"test999";
    request.HTTPBody = [self getHTTPBodyWithName:name];
       [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError * error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSString *str = [dict[@"code"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([str isEqualToString:@"N01"]){
            [self Success];
        }else{
            [self Fail];
        }
    }] resume];
    
}

- (void)Success{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"图片已经上传成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    }

- (void)Fail{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"图片上传失败，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSData *)getHTTPBodyWithName:(NSString *)name{
    //将需要上传的文件格式转换为二进制数据
    NSMutableData *data = [NSMutableData data];
    //上传文件的上边界
     NSMutableString *headerStrM = [NSMutableString stringWithFormat:@"--%@\r\n", kBoundary];
    [headerStrM appendFormat:@"Content-Disposition: form-data; name=\"file\";  filename=\"%@\"  \r\n ", @"WeFamily_icon.png"];
    
    [headerStrM appendFormat:@"Content-Type:application/octet-stream \r\n\r\n"];
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1004];
    
    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    
    NSData *photo = UIImagePNGRepresentation(image);
//    
//    NSData *photo = [NSData dataWithContentsOfFile:@"/Users/peterpan/Downloads/WeFamily_icon.png"];
    NSString *encodedImageStr = [photo base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"%@", encodedImageStr);
    NSString *session = [self getSessionId];
    NSDictionary *dict = @{@"sessionId":session,@"companySid":@"15", @"inputOrderSid":@"8", @"updateWriterNo":@"15335826555", @"updateWriterName":@"Jin", @"note":@"test", @"type":@"input"};
    NSLog(@"%@", session);
    
    for (NSString *key in dict) {
        //循环参数按照部分1、2、3那样循环构建每部分数据
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n",kBoundary,key];
        [data appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        
        id value = [dict objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [data appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([value isKindOfClass:[NSData class]]){
            [data appendData:value];
        }
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
   
    [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:photo];
    //一定要注意换行的问题，不能少换一行
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n\r\n--%@--\r\n", kBoundary];
    
    [data appendData:[footerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    return data;
}

- (NSString *)getSessionId{
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *path = [filePath stringByAppendingPathComponent:@"sessionId.plist"];
    
    NSDictionary *sessionDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSLog(@"%@", sessionDict);
    
    NSString *session = sessionDict[@"sessionId"];
   
    return session;
}

@end
