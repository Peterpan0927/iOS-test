//
//  leftMenuController.m
//  农产品拍易传App
//
//  Created by 潘振鹏 on 2017/9/7.
//  Copyright © 2017年 潘振鹏. All rights reserved.
//

#import "LeftMenuController.h"
#import "DrawerViewController.h"
#define SCREENBOUNDS [UIScreen mainScreen].bounds.size.width
@interface LeftMenuController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LeftMenuController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect frame = self.tableView.frame;
//    frame.origin.y = 0;
//    frame.size.height = 667;
//    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headerView.backgroundColor = [UIColor greenColor];
    
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENBOUNDS/2-80, 60, 80, 80)];
    imageView.image = [UIImage imageNamed:@"Van.jpeg"];
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 1.5f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:imageView];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}





- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"农事活动",@"企业信息",@"密码修改",@"关于",@"注销", nil];
    }
    return _dataArray;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = self.dataArray[indexPath.row];
    if([name isEqualToString:@"企业信息"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *AboutVc = [sb instantiateViewControllerWithIdentifier:@"About"];
        AboutVc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(turnBackToMainViewConttoller)];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:AboutVc];
        nav.navigationBar.barTintColor = [UIColor greenColor];
        [[DrawerViewController sharedDrawer] switchViewController:nav];
    }else if([name isEqualToString:@"关于"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *AboutCompanyVc = [sb instantiateViewControllerWithIdentifier:@"AboutCompany"];
        AboutCompanyVc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(turnBackToMainViewConttoller)];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:AboutCompanyVc];
        nav.navigationBar.barTintColor = [UIColor greenColor];
        [[DrawerViewController sharedDrawer] switchViewController:nav];
    }else if([name isEqualToString:@"密码修改"]){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *AboutCompanyVc = [sb instantiateViewControllerWithIdentifier:@"ResetPasswd"];
        AboutCompanyVc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(turnBackToMainViewConttoller)];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:AboutCompanyVc];
        nav.navigationBar.barTintColor = [UIColor greenColor];
        [[DrawerViewController sharedDrawer] switchViewController:nav];
    }else if([name isEqualToString:@"注销"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutSuccess" object:nil];
        });
    }
    

}

- (void)turnBackToMainViewConttoller{
    [[DrawerViewController sharedDrawer] swithToMainViewController];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
