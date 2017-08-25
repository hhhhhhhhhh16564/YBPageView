//
//  YBTitleStytle.h
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface YBTitleStytle : NSObject

//是否是滚动的title
@property (nonatomic,assign) BOOL isScrollEndble;

//title 默认颜色
@property(nonatomic, strong) UIColor *titleNomalColor;

//title 选中颜色
@property(nonatomic, strong) UIColor *titleSelectColor;

//titleView背景颜色
@property(nonatomic, strong) UIColor *titleBackColor;

// title之间的间距
@property (nonatomic,assign) CGFloat  marginSpace;

//高度
@property (nonatomic,assign) CGFloat titleHeight;

// 字体大小
@property(nonatomic, strong) UIFont *font;

// 是否显示底部的条
@property (nonatomic,assign) BOOL showBottonLine;

//底部条的高度
@property (nonatomic,assign) CGFloat bottomLineHeight;

//底部条的颜色
@property(nonatomic, strong) UIColor *bottomLineColor;














@end
