//
//  UIView+DLExtension.h
//  DLSideMenuVC
//
//  Created by Edward on 16/3/25.
//  Copyright © 2016年 M了个DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DLExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;

@end
