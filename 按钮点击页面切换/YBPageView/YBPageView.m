//
//  YBPageView.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBPageView.h"
#import "YBTitleView.h"
#import "YBContentView.h"



@interface YBPageView ()<YBTitleViewDelegate, YBContentViewDelegate>

@property(nonatomic, strong) YBTitleStytle *titleStyle;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSArray<UIViewController *> *childVcArray;
@property(nonatomic, strong) UIViewController *parentVc;


@property(nonatomic, strong) YBTitleView *titleView;
@property(nonatomic, strong) YBContentView *contentView;



@end



@implementation YBPageView
-(instancetype)initWithFrame:(CGRect)frame
                      stytle:(YBTitleStytle *)titleStyle
                      titles:(NSArray *)titleArray
                    childVcs:(NSArray<UIViewController *> *)childVcArray
                    parentVc:(UIViewController *)parentVc

{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleStyle = titleStyle;
        self.titleArray = titleArray;
        self.childVcArray = childVcArray;
        self.parentVc = parentVc;
        
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    //titleView
    CGRect titleFrame = CGRectMake(0, 0, self.frame.size.width, self.titleStyle.titleHeight);
    YBTitleView *titleView = [[YBTitleView alloc]initWithFrame:titleFrame style:self.titleStyle titles:self.titleArray];
    [self addSubview:titleView];
    titleView.delegate = self;
    self.titleView = titleView;
    

    CGRect contentFrame = CGRectMake(0, CGRectGetMaxY(titleFrame), self.frame.size.width, self.frame.size.height-self.titleStyle.titleHeight);
    YBContentView *contentView  = [[YBContentView alloc]initWithFrame:contentFrame childVcs:self.childVcArray parentVc:self.parentVc];
    contentView.delegate = self;
    [self addSubview:contentView];
    self.contentView = contentView;
    

}



#pragma mark 代理方法
-(void)titleView:(YBTitleView *)titleView didSelectedIndex:(NSInteger)index{
    
    [self.contentView titleView:titleView didSelectedIndex:index];
    
}


-(void)contetnView:(YBContentView *)contentView scrollProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex{
    [self.titleView contetnView:contentView scrollProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}























@end
