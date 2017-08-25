//
//  YBContentView.h
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@class YBTitleView;
@class YBContentView;

@protocol YBContentViewDelegate <NSObject>

-(void)contetnView:(YBContentView *)contentView scrollProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;
 
@end

@interface YBContentView : UIView

@property(nonatomic, weak) id<YBContentViewDelegate>  delegate;

-(void)titleView:(YBTitleView *)titleView didSelectedIndex:(NSInteger)index;
-(instancetype)initWithFrame:(CGRect)frame
                    childVcs:(NSArray <UIViewController *> *)childVcArray
                    parentVc:(UIViewController *)parentVc;


@end
