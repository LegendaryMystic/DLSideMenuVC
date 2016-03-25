//
//  HYOtherViewController.m
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/24.
//  Copyright © 2016年 com.huayikangdao. All rights reserved.
//

#import "HYOtherViewController.h"



@interface HYOtherViewController ()

@end

@implementation HYOtherViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"点击左侧菜单跳转的控制器";

    self.view.backgroundColor = [UIColor yellowColor];
    //很黄很暴力，请无视
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"生活不易，赏颗星星吧⭐️";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:28];
    [self.view addSubview:label];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
