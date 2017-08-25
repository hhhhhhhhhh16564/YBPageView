//
//  YBTitleStytle.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBTitleStytle.h"

@interface YBTitleStytle ()

@end

@implementation YBTitleStytle

-(instancetype)init{
    self = [super init];
    
    [self setDefaultConfig];
    
    return self;
}

-(void)setDefaultConfig{
    
    /*
     //是否是滚动的title
     @property (nonatomic,assign) BOOL isScrollEndble;
     
     //title 默认颜色
     @property(nonatomic, strong) UIColor *titleNomalColor;
     
     //title 选中颜色
     @property(nonatomic, strong) UIColor *titleSelectColor;
     
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
     */
    self.titleNomalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    self.titleSelectColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
    self.titleBackColor = [UIColor whiteColor];

    self.marginSpace = 10;
    self.titleHeight = 44;
    self.font = [UIFont systemFontOfSize:15];
    self.showBottonLine = NO;
    self.bottomLineHeight = 5;
    self.bottomLineColor = [UIColor grayColor];
    
    
}

@end
