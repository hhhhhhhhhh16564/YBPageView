//
//  YBTitleView.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBTitleView.h"

@interface YBTitleView()
@property(nonatomic, strong) YBTitleStytle *titleStyle;
@property(nonatomic, strong) NSArray *titleArray;

@property(nonatomic, strong) UIScrollView *scrollView;

//用来装所有的Label
@property(nonatomic, strong) NSMutableArray *lableArray;

//上一个选中的Label的 Index
@property (nonatomic,assign) NSUInteger oldIndex;
//这次选中的Index
@property (nonatomic,assign) NSUInteger newIndex;
@property(nonatomic, strong) UIView *bottomLineView;


@end

@implementation YBTitleView

-(instancetype)initWithFrame:(CGRect)frame
                       style:(YBTitleStytle *)titleStyle
                      titles:(NSArray *)titleArray{
    
    self = [super initWithFrame:frame];
    self.titleStyle = titleStyle;
    self.titleArray = titleArray;
    [self setupUI];
    
    return self;
}


-(void)setupUI{
    
    // 1. 添加scrollView
    [self setUPScrollView];
    
    // 2. 添加label
    [self setupTitles];
    
    //3 设置Label的frame
    [self setupTitleFrame];
    
    
    // 4. bottomView
    [self setupBottomLineView];
    
    // 默认选中第一个Lable
    [self tapAction:nil];
    
    
    
}

-(void)setUPScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}



-(void)setupTitles{

    self.lableArray = [NSMutableArray array];
    
    for (NSString *title in self.titleArray) {
        UILabel *label = [[UILabel alloc]init];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tapRecognize];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = title;
        label.font = self.titleStyle.font;
        label.textColor = self.titleStyle.titleNomalColor;
        [self.scrollView addSubview:label];
        [self.lableArray addObject:label];
        
//        label.backgroundColor = RandomColor;

    }
    
}



-(void)setupTitleFrame{
    
    NSUInteger count = self.titleArray.count;

    for (int i = 0; i < count; i++) {
        UILabel *lable = self.lableArray[i];
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = 0;
        CGFloat h = self.titleStyle.titleHeight;
        //可以滚动
        if (self.titleStyle.isScrollEndble) {
            
            NSString *title = self.titleArray[i];
            w = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleStyle.font} context:nil].size.width;

            
            if (i == 0) {
                x = self.titleStyle.marginSpace * 0.5;
            }else{
                UILabel *previousLabel = self.lableArray[i-1];
                x = CGRectGetMaxX(previousLabel.frame) + self.titleStyle.marginSpace;
            }
            //不能滚动
        }else{
            w = self.frame.size.width/count;
            x = i * w;
        }
        CGRect frame = CGRectMake(x, y, w, h);
        lable.frame = frame;
    }
    
    if (self.titleStyle.isScrollEndble) {
        UILabel *lastLabel = [self.lableArray lastObject];
        CGFloat width = CGRectGetMaxX(lastLabel.frame)+self.titleStyle.marginSpace*0.5;
        self.scrollView.contentSize = CGSizeMake(width,  self.frame.size.height);
        
    }else{
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    
     
    
}

-(void)setupBottomLineView{
    if (self.titleStyle.showBottonLine) {
        UIView *bottomLineView = [[UIView alloc]init];
        bottomLineView.backgroundColor = self.titleStyle.bottomLineColor;
        [self.scrollView addSubview:bottomLineView];
        self.bottomLineView = bottomLineView;

    }

  }
    
    


#pragma mark 点击事件

-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    self.newIndex = tap.view ? [self.lableArray indexOfObject:tap.view] : self.newIndex;
    
    // 1.点击时颜色改变
    UILabel *oldLabel = self.lableArray[self.oldIndex];
    UILabel *newLabel = self.lableArray[self.newIndex];
    
    oldLabel.textColor = self.titleStyle.titleNomalColor;
    newLabel.textColor = self.titleStyle.titleSelectColor;
    
    self.oldIndex = self.newIndex;
    
    // 2. 调整位置
    
    NSTimeInterval duration = 0;
    if (tap) {
        duration = 0.3;
    }
    

    [UIView animateWithDuration:duration animations:^{
        if (self.titleStyle.isScrollEndble) {
            //设置自动滚动
            CGFloat offsetX = newLabel.center.x - self.bounds.size.width*0.5;
            CGRect frame = CGRectMake(offsetX, 0, self.frame.size.width, self.frame.size.height);
            [self.scrollView scrollRectToVisible:frame animated:NO];
        }
        
        self.bottomLineView.frame = CGRectMake(newLabel.frame.origin.x, self.frame.size.height-self.titleStyle.bottomLineHeight, newLabel.frame.size.width, self.titleStyle.bottomLineHeight);

    }];
    

    // 3. 代理方法
    if ([self.delegate respondsToSelector:@selector(titleView:didSelectedIndex:)]) {
        [self.delegate titleView:self didSelectedIndex:self.newIndex];
    }
    
    
}





#pragma mark代理方法

-(void)contetnView:(YBContentView *)contentView scrollProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex{
    
    if (sourceIndex == targetIndex) {
        return;
    }
    
    // 1.点击时颜色改变
    UILabel *oldLabel = self.lableArray[sourceIndex];
    UILabel *newLabel = self.lableArray[targetIndex];
    
    NSMutableArray *nomalColorArray = [self changeUIColorToRGB:self.titleStyle.titleNomalColor];
    NSMutableArray *selectColorArray = [self changeUIColorToRGB:self.titleStyle.titleSelectColor];

    //红
    NSInteger differenceRed = [selectColorArray[0] integerValue] - [nomalColorArray[0] integerValue];
    //绿
    NSInteger differenceGreen = [selectColorArray[1] integerValue] - [nomalColorArray[1] integerValue];
    //蓝
    NSInteger differenceBlue = [selectColorArray[2] integerValue] - [nomalColorArray[2] integerValue];
    
    oldLabel.textColor = [UIColor colorWithRed:([selectColorArray[0] integerValue] - differenceRed * progress)/255.0 green:([selectColorArray[1] integerValue] - differenceGreen * progress)/255.0 blue:([selectColorArray[2] integerValue] - differenceBlue * progress)/255.0 alpha:1];
    
    
    newLabel.textColor = [UIColor colorWithRed:([nomalColorArray[0] integerValue] + differenceRed * progress)/255.0 green:([nomalColorArray[1] integerValue] + differenceGreen * progress)/255.0 blue:([nomalColorArray[2] integerValue] + differenceBlue * progress)/255.0 alpha:1];

    self.oldIndex = targetIndex;
    
    // 2. 调整位置
        if (self.titleStyle.isScrollEndble) {
            //设置自动滚动
            CGFloat sourceOffsetX = oldLabel.center.x - self.bounds.size.width*0.5;
            CGFloat targetOffsetX = newLabel.center.x - self.bounds.size.width*0.5;
            targetOffsetX = sourceOffsetX + (targetOffsetX-sourceOffsetX)*progress;
          
            if (targetOffsetX <= 0) {
                targetOffsetX = 0;
            }
            CGFloat maxOffsetx = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
            
            if (targetOffsetX >= maxOffsetx) {
                targetOffsetX = maxOffsetx;
            }
            
            [self.scrollView setContentOffset:CGPointMake(targetOffsetX, 0) animated:NO];
            
        
        }
            
        CGFloat y = self.frame.size.height-self.titleStyle.bottomLineHeight;
        CGFloat H = self.titleStyle.bottomLineHeight;
        CGFloat w = self.frame.size.width/self.titleArray.count;
        CGFloat x = oldLabel.frame.origin.x + (newLabel.frame.origin.x-oldLabel.frame.origin.x)*progress;

        if (self.titleStyle.isScrollEndble) {
            
            w = oldLabel.frame.size.width + (newLabel.frame.size.width-oldLabel.frame.size.width)*progress;
        }
        
        self.bottomLineView.frame = CGRectMake(x, y, w, H);

    
    
}

//将UIColor转换为RGB值
- (NSMutableArray *) changeUIColorToRGB:(UIColor *)color
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    
    //  UIExtendedSRGBColorSpace 0.972549 0.392157 0.0901961 1

    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];

    
    
    NSAssert([RGBArr count] == 5, @"所传的颜色必须是RGB颜色");

    //获取红色值
    int r = [[RGBArr objectAtIndex:1] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",r];
    [RGBStrValueArr addObject:RGBStr];
    //获取绿色值
    int g = [[RGBArr objectAtIndex:2] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",g];
    [RGBStrValueArr addObject:RGBStr];
    //获取蓝色值
    int b = [[RGBArr objectAtIndex:3] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",b];
    [RGBStrValueArr addObject:RGBStr];
    //返回保存RGB值的数组
    return RGBStrValueArr;
}



@end
