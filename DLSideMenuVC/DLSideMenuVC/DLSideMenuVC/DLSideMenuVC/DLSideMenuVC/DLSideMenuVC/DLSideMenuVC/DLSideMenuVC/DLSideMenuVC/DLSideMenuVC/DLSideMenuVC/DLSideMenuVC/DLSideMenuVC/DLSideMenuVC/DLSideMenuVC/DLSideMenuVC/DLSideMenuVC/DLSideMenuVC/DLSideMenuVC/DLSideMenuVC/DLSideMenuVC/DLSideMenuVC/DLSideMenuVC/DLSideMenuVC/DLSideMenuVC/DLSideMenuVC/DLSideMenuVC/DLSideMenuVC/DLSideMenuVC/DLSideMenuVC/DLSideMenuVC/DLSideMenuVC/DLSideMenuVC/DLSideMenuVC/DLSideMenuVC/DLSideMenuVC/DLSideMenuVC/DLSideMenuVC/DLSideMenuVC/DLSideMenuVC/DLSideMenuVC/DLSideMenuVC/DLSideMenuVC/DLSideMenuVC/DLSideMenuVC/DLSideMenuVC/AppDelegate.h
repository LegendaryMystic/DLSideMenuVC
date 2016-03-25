//
//  AppDelegate.h
//  HYKD
//
//  Created by Edward on 16/3/24.
//  Copyright © 2016年 com.huayikangdao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYSlideViewController.h"
#import "HYNaVViewController.h"

#import "HYMainNavController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 侧滑抽屉 */
@property (nonatomic, strong) HYSlideViewController *slideVc;
/** 主界面导航控制器 */
@property (nonatomic, strong) HYMainNavController *mainNav;
@end

