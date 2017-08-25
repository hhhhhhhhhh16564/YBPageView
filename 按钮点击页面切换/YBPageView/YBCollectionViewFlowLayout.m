//
//  YBCollectionViewFlowLayout.m
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/22.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBCollectionViewFlowLayout.h"

@interface YBCollectionViewFlowLayout ()

@property(nonatomic, strong) NSMutableArray *layoutAttributesArray;

//行的个数
@property (nonatomic,assign) NSInteger rowCount;

//列的个数
@property (nonatomic,assign) NSInteger columnCount;

//行间距
@property (nonatomic,assign) CGFloat rowMargin;

//列间距
@property (nonatomic,assign) CGFloat columnMargin;


//四周间距
@property (nonatomic,assign) UIEdgeInsets inset;

//cell的宽度

@property (nonatomic,assign) CGFloat itemWidth;

//cell的高度
@property (nonatomic,assign) CGFloat itemHeight;

@property(nonatomic, assign) NSUInteger currentPage;

@property (nonatomic,assign) CGFloat maxWidth;

@end

@implementation YBCollectionViewFlowLayout

-(NSMutableArray *)layoutAttributesArray{
    
    if (!_layoutAttributesArray) {
        _layoutAttributesArray = [NSMutableArray array];
    }
    return _layoutAttributesArray;
}


-(NSInteger)rowCount{
    if (_rowCount) {
        return _rowCount;
    }
    if ([self.flowoutDelegate respondsToSelector:@selector(rowCountInWaterFlowLayout:)]) {
        _rowCount = [self.flowoutDelegate rowCountInWaterFlowLayout:self];
    }else{
        NSAssert(0, @"请实现代理方法:rowCountInWaterFlowLayout");
    }
    return _rowCount;
}
-(NSInteger)columnCount{
    if (_columnCount) {
        return _columnCount;
    }
    if ([self.flowoutDelegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        _columnCount = [self.flowoutDelegate columnCountInWaterFlowLayout:self];
    }else{
        NSAssert(0, @"请实现代理方法:columnCountInWaterFlowLayout");
    }
    return _columnCount;
}


-(CGFloat)rowMargin{
    if ([self.flowoutDelegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        _rowMargin = [self.flowoutDelegate rowMarginInWaterFlowLayout:self];
    }else{
        _rowMargin = 0;
    }
    return _rowMargin;
}

-(CGFloat)columnMargin{
    if ([self.flowoutDelegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        _columnMargin = [self.flowoutDelegate columnMarginInWaterFlowLayout:self];
    }else{
        _columnMargin = 0;
    }
    return _columnMargin;
}

-(UIEdgeInsets)inset{
    if ([self.flowoutDelegate respondsToSelector:@selector(edgeInWaterFlowLayout:)]) {
        _inset = [self.flowoutDelegate edgeInWaterFlowLayout:self];
    }else{
        _inset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _inset;
}



-(CGFloat)itemWidth{
    if (_itemWidth) {
        return _itemWidth;
    }
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    _itemWidth = (collectionWidth-self.inset.left-self.inset.right-(self.columnCount-1)*self.columnMargin)/self.columnCount;
    return _itemWidth;
}

-(CGFloat)itemHeight{
    if (_itemHeight) {
        return _itemHeight;
    }
    CGFloat collectionHeight = self.collectionView.bounds.size.height;
  _itemHeight = (collectionHeight-self.inset.top-self.inset.bottom-(self.rowCount-1)*self.rowMargin)/self.rowCount;
    return _itemHeight;
}


-(void)prepareLayout{
    
    [super prepareLayout];
    NSLog(@"初始化\n\n\n\\n\n\\n\n\n\n");
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    for (int i = 0; i < sectionCount; i++) {
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        
        for (int j = 0; j < itemCount; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(j) inSection:i];
            
            UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [self.layoutAttributesArray addObject:layoutAttributes];
            
        }
        
        // currentPage下标从1开始
        self.currentPage += (itemCount - 1)/(self.rowCount*self.columnCount) +1;
        
        self.maxWidth = self.currentPage * self.collectionView.bounds.size.width;
    }
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"布局");
    
    
    
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
//    CGFloat collectionHeight = self.collectionView.bounds.size.height;
    

    CGFloat w = self.itemWidth;
    CGFloat h = self.itemHeight;
    
    NSInteger pageCount = self.rowCount * self.columnCount;
   
//    NSLog(@"%zd", self.columnCount);
    
    //计算出在该页是第几个，因为一个分区可能有多页
    NSInteger index = indexPath.row % pageCount;
    
    //横着排，不要竖着排
    NSInteger row = index /self.columnCount;
    NSInteger col = index % self.columnCount;
    
 // x分三部分组成：  该page的x  加上该分区的其它page* width + 其它分区的偏移量
    CGFloat x = (self.inset.left + (self.columnMargin+w)* col) + ((indexPath.row+1-1)/pageCount+1-1)*collectionWidth+ self.currentPage*collectionWidth;
    
    CGFloat y =  self.inset.top +(self.rowMargin+h) * row;
    
    UICollectionViewLayoutAttributes * layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttributes.frame = CGRectMake(x, y, w, h);
    
    
//    NSLog(@"%@", NSStringFromCGRect(layoutAttributes.frame));
    
    return layoutAttributes;
    
}




- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    
    return self.layoutAttributesArray;
}


-(CGSize)collectionViewContentSize{
    
    return CGSizeMake(self.maxWidth, self.collectionView.bounds.size.height);
    
}









@end
