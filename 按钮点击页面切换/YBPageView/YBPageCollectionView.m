//
//  YBPageCollectionView.m
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/21.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBPageCollectionView.h"
#import "YBTitleView.h"
@interface YBPageCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, YBTitleViewDelegate>
@property(nonatomic, strong) YBTitleStytle *style;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, assign) BOOL  isTop;
@property(nonatomic, strong) YBCollectionViewFlowLayout *layout;


@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) YBTitleView *titleView;

@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) NSMutableArray *sectionIndexPathArray;

@property(nonatomic, strong) NSIndexPath *sourceIndexPath;

@end


@implementation YBPageCollectionView
- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier{
    
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    
}
- (void)registerNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier{
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}




//************************************************************/

//保留了分区可见的第一个indexPath
-(NSMutableArray *)sectionIndexPathArray{
    if (!_sectionIndexPathArray) {
        _sectionIndexPathArray = [NSMutableArray array];
        
        for (int i = 0; i < self.titles.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            [_sectionIndexPathArray addObject:indexPath];
        }
    }
    return _sectionIndexPathArray;
}





-(instancetype)initWithFrame:(CGRect)frame titleStyle:(YBTitleStytle *)style titles:(NSArray *)titles isTitleTop:(BOOL)isTop layout:(__kindof YBCollectionViewFlowLayout *)layout{
    self = [super initWithFrame:frame];
    self.style = style;
    self.titles = titles;
    self.isTop = isTop;
    self.layout = layout;
    [self setupUI];
    self.sourceIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    return self;
}


-(void)setupUI{
    
//    self.isTop = NO;
    //1. titleView
    
    CGFloat titleY = self.isTop ? 0 : (self.bounds.size.height-self.style.titleHeight);
    
    CGRect titleFrame = CGRectMake(0, titleY, self.bounds.size.width, self.style.titleHeight);

    YBTitleView *titleView = [[YBTitleView alloc]initWithFrame:titleFrame style:self.style titles:self.titles];
    titleView.delegate = self;
    [self addSubview:titleView];
    self.titleView = titleView;
    
    NSLog(@"%f", titleY);
    
    
    //2. pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
//    pageControl.pageIndicatorTintColor = [UIColor redColor];
    CGFloat pageControlHeight = 20;
    CGFloat pageY = self.isTop ? self.bounds.size.height - pageControlHeight : self.bounds.size.height - self.style.titleHeight-pageControlHeight;
    pageControl.frame = CGRectMake(0, pageY, self.bounds.size.width, pageControlHeight);
    pageControl.enabled = NO;
    pageControl.numberOfPages = self.titles.count;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
  
    //3. collectionView
    CGFloat collectionY = self.isTop ? self.style.titleHeight : 0;
    CGRect collectionFrame = CGRectMake(0, collectionY, self.bounds.size.width, self.bounds.size.height-pageControlHeight-self.style.titleHeight);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:collectionFrame collectionViewLayout:self.layout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    self.backgroundColor = [UIColor grayColor];
    
    self.titleView.backgroundColor = [UIColor yellowColor];
    self.collectionView.backgroundColor = [UIColor greenColor];
    self.pageControl.backgroundColor = [UIColor grayColor];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [self.dataSource numberOfSectionsInPageCollectionView:self];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataSource pageCollectionView:self numberOfItemsInSection:section];
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSource pageCollectionView:self collectionView:collectionView cellForItemAtIndexPath:indexPath];

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    [self.dataSource pageCollectionView:self didSelectItemAtIndexPath:indexPath];
}

#pragma mark 代理方法


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    scrollView.scrollEnabled = NO;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self endScroll];
    }
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self endScroll];
}

-(void)endScroll{
    self.collectionView.scrollEnabled = YES;
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(self.collectionView.contentOffset.x+self.layout.inset.left+2, 0)];
    [self.sectionIndexPathArray setObject:indexPath atIndexedSubscript:indexPath.section];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:indexPath.section];
    NSInteger pageCount = (itemCount-1)/(self.layout.rowCount*self.layout.columnCount)+1;
    self.pageControl.numberOfPages = pageCount;
    if (indexPath.section != self.sourceIndexPath.section) {
        [self.titleView contetnView:nil scrollProgress:1 sourceIndex:self.sourceIndexPath.section targetIndex:indexPath.section];
        self.sourceIndexPath = indexPath;
    }
    self.pageControl.currentPage = indexPath.item/(self.layout.rowCount*self.layout.columnCount);
}


//代理方法
-(void)titleView:(YBTitleView *)titleView didSelectedIndex:(NSInteger)index{
    [self.collectionView scrollToItemAtIndexPath:self.sectionIndexPathArray[index] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
}






@end
