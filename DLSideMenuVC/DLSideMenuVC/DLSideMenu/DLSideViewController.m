//
//  HYSlideViewController.m
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/24.
//  Copyright © 2016年 com.huayikangdao. All rights reserved.
//

#import "DLSideViewController.h"
#import "UIView+DLExtension.h"
@interface DLSideViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat _scalef;  //实时横向位移
}

@property (nonatomic,strong) UITableView *leftTableview;
@property (nonatomic,assign) CGFloat leftTableviewW;
@property (nonatomic,strong) UIView *contentView;
@end


@implementation DLSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC
{
    if(self = [super init]){
        self.speedf = vSpeedFloat;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        [self addChildViewController:self.leftVC];
        [self addChildViewController:self.mainVC];
        //滑动手势
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self.mainVC.view addGestureRecognizer:self.pan];
        
        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
        
        self.leftVC.view.hidden = YES;
        
        [self.view addSubview:self.leftVC.view];
        
        //蒙版
        UIView *view = [[UIView alloc] init];
        view.frame = self.leftVC.view.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        self.contentView = view;
        [self.leftVC.view addSubview:view];
        
        //获取左侧tableview
        for (UIView *obj in self.leftVC.view.subviews) {
            if ([obj isKindOfClass:[UITableView class]]) {
                self.leftTableview = (UITableView *)obj;
            }
        }
        self.leftTableview.backgroundColor = [UIColor clearColor];
        self.leftTableview.frame = CGRectMake(0, 0, DLScreenWidth - DLMainPageDistance, DLScreenHeight);
        //设置左侧tableview的初始位置和缩放系数
        self.leftTableview.transform = CGAffineTransformMakeScale(DLLeftScale, DLLeftScale);
        self.leftTableview.center = CGPointMake(DLLeftCenterX, DLScreenHeight * 0.5);
        
        [self.view addSubview:self.mainVC.view];
        
        //初始时侧滑窗关闭
        self.closed = YES;
        
        //默认设置边缘滑动  可滑动宽度为30（只有非全屏滑动时才有用）
        self.leftEdge = 30.0;
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.leftVC.view.hidden = NO;
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    _scalef = (point.x * self.speedf + _scalef);
    
    BOOL needMoveWithTap = YES;  //是否还需要跟随手指移动
    if (((self.mainVC.view.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.x >= (DLScreenWidth - DLMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (rec.view.frame.origin.x >= 0) && (rec.view.frame.origin.x <= (DLScreenWidth - DLMainPageDistance)))
    {
        CGFloat recCenterX = rec.view.center.x + point.x * self.speedf;
        if (recCenterX < DLScreenWidth * 0.5 - 2) {
            recCenterX = DLScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = rec.view.center.y;
        
        rec.view.center = CGPointMake(recCenterX,recCenterY);
        
        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - DLMainPageScale) * (rec.view.frame.origin.x / (DLScreenWidth - DLMainPageDistance));
        
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = DLLeftCenterX + ((DLScreenWidth - DLMainPageDistance) * 0.5 - DLLeftCenterX) * (rec.view.frame.origin.x / (DLScreenWidth - DLMainPageDistance));
        
//        NSLog(@"%f",leftTabCenterX);
        
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = DLLeftScale + (1 - DLLeftScale) * (rec.view.frame.origin.x / (DLScreenWidth - DLMainPageDistance));
        
        self.leftTableview.center = CGPointMake(leftTabCenterX, DLScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = DLLeftAlpha - DLLeftAlpha * (rec.view.frame.origin.x / (DLScreenWidth - DLMainPageDistance));
        self.contentView.alpha = tempAlpha;
        
    }
    else
    {
        //超出范围，
        if (self.mainVC.view.x < 0)
        {
            [self closeLeftView];
            _scalef = 0;
        }
        else if (self.mainVC.view.x > (DLScreenWidth - DLMainPageDistance))
        {
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.closed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self.closed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        self.closed = YES;
        
        self.leftTableview.center = CGPointMake(DLLeftCenterX, DLScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,DLLeftScale,DLLeftScale);
        self.contentView.alpha = DLLeftAlpha;
        
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVC.view.center = CGPointMake(DLScreenWidth / 2, DLScreenHeight / 2);
    self.closed = YES;
    
    self.leftTableview.center = CGPointMake(DLLeftCenterX, DLScreenHeight * 0.5);
    self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,DLLeftScale,DLLeftScale);
    self.contentView.alpha = DLLeftAlpha;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,DLMainPageScale,DLMainPageScale);
    self.mainVC.view.center = DLMainPageCenter;
    self.closed = NO;
    
    self.leftTableview.center = CGPointMake((DLScreenWidth - DLMainPageDistance) * 0.5, DLScreenHeight * 0.5);
    self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}

#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [_mainVC.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.mainVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */

- (void)setPanEnabled: (BOOL) enabled
{
    [self.pan setEnabled:enabled];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
//    if(touch.view.tag == vDeckCanNotPanViewTag)
//    {
//        //        NSLog(@"不响应侧滑");
//        return NO;
//    }
//    else
//    {
//        //        NSLog(@"响应侧滑");
//        return YES;
//    }
    
    
    //全屏滑动 Or just  边缘滑动
    if (self.panOnEdge) {
       //若边缘滑动，初始化完成时设置leftEdge参数
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x < self.leftEdge) {
            return YES;
        } else {
            return NO;
        }
    }else{
        return YES;
    }
 


}

@end
