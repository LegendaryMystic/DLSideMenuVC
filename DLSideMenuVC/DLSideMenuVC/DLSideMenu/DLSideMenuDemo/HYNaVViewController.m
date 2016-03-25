//
//  HYNaVViewController.m
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/1.
//  Copyright © 2016年 Mystic. All rights reserved.
//

#import "HYNaVViewController.h"

#import "UIImage+HYExtension.h"

#define NavBarBGColor [UIColor colorWithRed:39.0/255 green:199.0/255 blue:186.0/255 alpha:1.0]

@interface HYNaVViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HYNaVViewController

+ (void)initialize
{
    /**
     *  设置UINavigationBar
     */
    UINavigationBar *bar = [UINavigationBar appearance];
    
//    bar.backgroundColor = NavBarBGColor;
    
    UIImage *navBg = [UIImage imageWithColor:NavBarBGColor];
    
    [bar setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];

    //设置背景
//    [bar setBackgroundImage:[UIImage imageNamed:@"确定"] forBarMetrics:UIBarMetricsDefault];
    
    //设置标题文字属性
    NSMutableDictionary *barAttributes = [NSMutableDictionary dictionary];
    barAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    barAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:barAttributes];
    
    
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    

}


/**
 *  拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //if（不是第一个push进来的子控制器）
    if (self.childViewControllers.count >=1) {
        //左上角的返回
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        //设置返回按钮标题
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        
//        //设置标题颜色
//        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        
        //设置按钮图片

        [backButton setImage:[UIImage imageNamed:@"return_bar_btn"] forState:UIControlStateNormal];
        
        //根据图片大小设置按钮size
        [backButton sizeToFit];
        
        //内边距
//        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        //监听按钮点击
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        //设置导航栏左边Item为自定义返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        
        //隐藏底部工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
//        self.navigationBarHidden = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>

/**
 *  每当用户出发【返回手势】时都会调用一次这个方法
 *  返回值：返回为YES手势有效；返回为NO手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //如果当前是第一个子控制器，就应该禁止掉返回手势
    //    if (self.childViewControllers.count == 1) return NO;
    //
    //    return YES;
    
    return self.childViewControllers.count >1;
}

@end
