//
//  YBPageView.h
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBTitleStytle.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]


@interface YBPageView : UIView

-(instancetype)initWithFrame:(CGRect)frame
                      stytle:(YBTitleStytle *)titleStyle
                      titles:(NSArray *)titleArray
                    childVcs:(NSArray <UIViewController *> *)childVcArray
                    parentVc:(UIViewController *)parentVc;

@end
