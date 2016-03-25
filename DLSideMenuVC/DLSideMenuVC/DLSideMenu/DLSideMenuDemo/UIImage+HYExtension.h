//
//  UIImage+HYExtension.h
//  HYKD
//  俺的博客http://www.cnblogs.com/mysticCoder/
//  Created by Edward on 16/3/8.
//  Copyright © 2016年 Mystic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HYExtension)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
