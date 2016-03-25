
//
//  HYTabBarController.m
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/2.
//  Copyright © 2016年 Mystic. All rights reserved.
//

#import "HYTabBarController.h"
#import "AppDelegate.h"
//#import "HYTabBar.h"
#import "HYNaVViewController.h"

#import "HYHomeViewController.h"
//#import "HYMineViewController.h"
//#import "HYKnowledgeViewController.h"
//#import "HYDiagnoseViewController.h"

//#import "HYPersonalViewController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    // 设置item属性
    [self setupItem];
    
    // 添加所有的子控制器
    [self setupChildVcs];
    
    

//    // 处理TabBar
//    [self setupTabBar];
    
}

/**
 * 处理TabBar
 */
//- (void)setupTabBar
//{
//    [self setValue:[[HYTabBar alloc] init] forKeyPath:@"tabBar"];
//}

/**
 * 添加所有的子控制器
 */
- (void)setupChildVcs
{

    HYHomeViewController *home = [[HYHomeViewController alloc] init];
    [self setupChildVc:home title:@"首页"image:@"heart" selectedImage:@"heart"];
    
    [self setupChildVc:[[UIViewController alloc
                         ] init] title:@"服务" image:@"heart" selectedImage:@"heart"];
    
    [self setupChildVc:[[UIViewController alloc
                         ] init] title:@"发现" image:@"heart" selectedImage:@"heart"];


}

/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 包装一个导航控制器
   HYNaVViewController *nav = [[HYNaVViewController alloc] initWithRootViewController:vc];
    
   
    
    [self addChildViewController:nav];
    
    // 设置子控制器的tabBarItem
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}

/**
 * 设置item属性
 */
- (void)setupItem
{
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 统一给所有的UITabBarItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR的属性或方法, 才可以通过appearance对象来统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
  
    NSLog(@"%s",__func__);
   
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.slideVc setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

NSLog(@"%s",__func__);
    
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.slideVc setPanEnabled:YES];
    
    
//     self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}




- (void)dealloc
{
    NSLog(@"%s",__func__);
    
}
@end
