//
//  HYLeftViewController.m
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/24.
//  Copyright © 2016年 com.huayikangdao. All rights reserved.
//

#import "HYLeftViewController.h"
#import "HYOtherViewController.h"
#import "AppDelegate.h"

@interface HYLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HYLeftViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"Stars"];
    [self.view addSubview:imageview];
    
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"健康档案";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"购药订单";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"我的社区";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"百科收藏";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"设置于帮助";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"意见反馈";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
       [tempAppDelegate.slideVc closeLeftView];//关闭左侧抽屉
    HYOtherViewController *vc = [[HYOtherViewController alloc] init];
//#ifdef TABRoot
//    
//    // 修改根视图为标签栏控制器
//  
//    AppDelegate* appDelagete = [UIApplication sharedApplication].delegate;
//   
//    appDelagete.window.rootViewController = tabBarController;
//    
//#else
//  
//    // 把标签栏视图控制器push到导航栏控制器内
//  
//    [self.navigationController pushViewController:self.tabBarController animated:YES];
//    
//#endif
  
    [tempAppDelegate.mainNav pushViewController:vc animated:NO];
//    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%@-------%@",self.navigationController,tempAppDelegate.mainNav);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end