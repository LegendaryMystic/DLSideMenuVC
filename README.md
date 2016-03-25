# DLSideMenuVC
A sample demo for the left - side Menu just the old version of QQ.简易抽屉效果DEMO，类似QQ

# 效果预览图：
![image](https://github.com/LegendaryMystic/DLSideMenuVC/blob/master/ReadMeImages/Side.gif?raw=true)

# API :(详情参看DLSideViewController.h)
```objc
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

```
# How to Use (参看demo .....(*^__^*) ）

# 备注：
## 关于Demo
###   这个简单的小demo 是俺工作闲暇时间花半天时间所写，多有鄙陋，还请各位大大指正，
###   目前本人水平浅薄，封装能力低微，很多代码写的不尽人意，还望见谅，最近开始忙了，后续有空将会稍加完善，目前提供如效果图所示缩放侧滑抽屉效果，默认是全屏手势侧滑，提供接口可选择类似QQ的仅边缘侧滑
```objc
/** 是否支持边缘滑动（非全屏滑动）*/
@property (nonatomic, assign) BOOL panOnEdge;
```
#### 还有很多参数抽成宏了，没有封装，demo比较简单，大家可自行  在宏里面修改参数

## 值得指出的是还有一个小细节：当主界面视图，比如首页是tableView时，滚动tableView了 必须等到它滚动减速停止，侧滑效果才能使用。影响不大，目前尚不知原因，后续业余时间 将修复
## 如有大神一眼看出玄机，还望赐教，诚谢！

## 我的博客：http://www.cnblogs.com/mysticCoder/   (*^__^*) ……
