//
//  YBContentView.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBContentView.h"

@interface YBContentView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property(nonatomic, strong)NSArray<UIViewController *> *childVcArray;

@property(nonatomic, strong)UIViewController *parentVc;

@property(nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,assign) CGFloat contentOffsetX;


@property (nonatomic,assign) BOOL isForbiddenScroll;

@end

@implementation YBContentView

-(instancetype)initWithFrame:(CGRect)frame
                    childVcs:(NSArray <UIViewController *> *)childVcArray
                    parentVc:(UIViewController *)parentVc{
    
    self = [super initWithFrame:frame];
    self.childVcArray = childVcArray;
    self.parentVc = parentVc;
    [self setupUI];
    return self;
    
}

-(void)setupUI{
    
    
    [self addchildsVC];
    [self setupCollectionView];
    
    
}

-(void)addchildsVC{
    
    for (UIViewController *VC in self.childVcArray) {
        [self.parentVc addChildViewController:VC];
    }
    
    
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"jjj"];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}


#pragma parmk collectionView 代理方法


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jjj" forIndexPath:indexPath];
    [[cell.contentView.subviews firstObject] removeFromSuperview];
    UIView *subView = self.childVcArray[indexPath.row].view;
    subView.backgroundColor = RandomColor;
    [cell addSubview:subView];
    return cell;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childVcArray.count;
}



#pragma parmk YBtitleView 代理方法
-(void)titleView:(YBTitleView *)titleView didSelectedIndex:(NSInteger)index{
    self.isForbiddenScroll = YES;

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    

}

#pragma scrollView的代理方法

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.isForbiddenScroll = NO;
    self.contentOffsetX = scrollView.contentOffset.x;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isForbiddenScroll) return;
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewWidth = self.bounds.size.width;
    
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    CGFloat   progress = 0;
    
    
    //向右滑动
    if (currentOffsetX < self.contentOffsetX) {
        progress = (self.contentOffsetX - currentOffsetX)/scrollViewWidth;

        targetIndex = currentOffsetX/self.bounds.size.width;
        sourceIndex = targetIndex + 1;
        
        
        
        if (sourceIndex >= self.childVcArray.count) {
            sourceIndex = self.childVcArray.count - 1;
        }

        // 向左滑动
    }else{
        progress = (currentOffsetX - self.contentOffsetX)/scrollViewWidth;

       sourceIndex = currentOffsetX/self.bounds.size.width;
       targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVcArray.count) {
            targetIndex = self.childVcArray.count - 1;
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(contetnView:scrollProgress:sourceIndex:targetIndex:)] && progress<1.0) {
        
        [self.delegate contetnView:self scrollProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
    
 
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    scrollView.scrollEnabled = NO;

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self collectionViewEndScroll];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self collectionViewEndScroll];
}

-(void)collectionViewEndScroll{
    
    self.isForbiddenScroll = YES;
    self.collectionView.scrollEnabled = YES;
    NSLog(@"结束拖拽");

}



@end
