//
//  YBTitleView.h
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBTitleStytle.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@class YBTitleView;
@class YBContentView;
@protocol YBTitleViewDelegate <NSObject>

-(void)titleView:(YBTitleView *)titleView didSelectedIndex:(NSInteger)index;

@end

@interface YBTitleView : UIView
@property (nonatomic,weak) id<YBTitleViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame
                       style:(YBTitleStytle *)titleStyle
                      titles:(NSArray *)titleArray;



-(void)contetnView:(YBContentView *)contentView scrollProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end
