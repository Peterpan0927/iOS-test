//
//  LoginViewController.m
//  农产品拍易传App
//
//  Created by 潘振鹏 on 2017/9/7.
//  Copyright © 2017年 潘振鹏. All rights reserved.
//

#import "LoginViewController.h"
#import "DrawerViewController.h"
#import "underLine.h"
#import "NetWorkTool.h"


@interface LoginViewController ()<NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet underLine *userNameField;
@property (weak, nonatomic) IBOutlet underLine *userPasswordFild;

@end


static NSDictionary *dict1;



@implementation LoginViewController


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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setborder:self.loginBtn WithRedis:6 AndBorderWidth:1.0 AndBorderColor:[UIColor grayColor]];
    self.userPasswordFild.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnCLick:(id)sender {
    __block NSString *str;
    if(self.userPasswordFild.text.length && self.userNameField.text.length){
        NetWorkTool *tool = [NetWorkTool sharedNetWordTool];
        NSDictionary *dict = @{@"userNo":self.userNameField.text, @"password":self.userPasswordFild.text};
        
        [tool postWithSuccess:^(NSData *data, NSURLResponse *response) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            str = [dict[@"code"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            if([str isEqualToString:@"N01"]){
                NSLog(@"success");
               //要保持同步，所以要返回主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                });
                [self saveSession:dict];
            }else{
                NSLog(@"failed");
            }
        } failBlock:^(NSError *error) {
            NSLog(@"sad");
        } andDict:dict];
    }
}

- (void)saveSession:(NSDictionary *)dict{
    NSDictionary *dict1 = dict[@"contents"];
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *path = [filePath stringByAppendingPathComponent:@"sessionId.plist"];
    [dict1 writeToFile:path atomically:YES];
    NSLog(@"%@", path);
}

+ (instancetype)sharedLoginVc{
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return  _instance;
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
