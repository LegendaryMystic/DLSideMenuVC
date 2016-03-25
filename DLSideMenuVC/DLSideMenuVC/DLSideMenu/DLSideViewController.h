//
//  DLSideViewController.h
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/24.
//  Copyright © 2016年 com.huayikangdao. All rights reserved.
//
#define DLScreenSize           [[UIScreen mainScreen] bounds].size
#define DLScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define DLScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define DLMainPageDistance   100   //打开左侧窗时，中视图(右视图)露出的宽度
#define DLMainPageScale   0.8  //打开左侧窗时，中视图(右视图）缩放比例
#define DLMainPageCenter  CGPointMake(DLScreenWidth + DLScreenWidth * DLMainPageScale / 2.0 - DLMainPageDistance, DLScreenHeight / 2)  //打开左侧窗时，中视图中心点

#define vCouldChangeDeckStateDistance  (DLScreenWidth - DLMainPageDistance) / 2.0 - 40 //滑动距离大于此数时，状态改变（关--》开，或者开--》关）
#define vSpeedFloat   0.7    //滑动速度

#define DLLeftAlpha 0.9  //左侧蒙版的最大值
#define DLLeftCenterX 30 //左侧初始偏移量
#define DLLeftScale 0.7 //左侧初始缩放比例

#define vDeckCanNotPanViewTag    10086   // 不响应此侧滑的View的tag



#import <UIKit/UIKit.h>

@interface DLSideViewController : UIViewController

/** 滑动速度系数-建议在0.5-1之间。默认为0.5 */
@property (nonatomic, assign) CGFloat speedf;


/** 左侧窗控制器 */
@property (nonatomic, strong) UIViewController *leftVC;

@property (nonatomic,strong) UIViewController *mainVC;
/** 点击手势控制器，是否允许点击视图恢复视图位置。默认为yes */
@property (nonatomic, strong) UITapGestureRecognizer *sideslipTapGes;

/** 滑动手势 */
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

/** 侧滑窗是否关闭(缩放） */
@property (nonatomic, assign) BOOL closed;//(注：关闭时显示为主页)

/** 是否支持边缘滑动（非全屏滑动）*/
@property (nonatomic, assign) BOOL panOnEdge;

/** 在仅边缘滑动的情况下，此参数可设置最侧可滑动范围宽度（原则上最好不要超过屏幕宽度一半 */
@property (nonatomic, assign) CGFloat leftEdge;

/**
 *  构造方法 初始化侧滑抽屉控制器
 *
 *  @param leftVC 左边抽屉视图控制器
 *  @param mainVC 中间主视图控制器
 *
 *  @return return value description 初始化对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC;

/**
 *  关闭左视图
 */
- (void)closeLeftView;


/**
 *  打开左视图 （侧滑缩放状态）
 */
- (void)openLeftView;

/**
 *  设置滑动手势开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled: (BOOL) enabled;

@end
