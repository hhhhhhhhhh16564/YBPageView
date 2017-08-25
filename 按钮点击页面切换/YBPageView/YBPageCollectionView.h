//
//  YBPageCollectionView.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/21.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBTitleStytle.h"

#import "YBCollectionViewFlowLayout.h"

@class YBContentView;
@class YBPageCollectionView;
@protocol YBPageCollectionViewDataSoruce <NSObject>

NS_ASSUME_NONNULL_BEGIN
- (__kindof UICollectionViewCell *)pageCollectionView:(YBPageCollectionView *)pagecollectionView  collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInPageCollectionView:(YBPageCollectionView *)pageCollectionView;

-(NSInteger)pageCollectionView:(YBPageCollectionView *)pagecollectionView numberOfItemsInSection:(NSInteger)section;
-(void)pageCollectionView:(YBPageCollectionView *)pagecollectionVie didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface YBPageCollectionView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleStyle:(YBTitleStytle *)style titles:(NSArray *)titles isTitleTop:(BOOL)isTop layout:(YBCollectionViewFlowLayout *)layout;

@property (nonatomic,weak) id<YBPageCollectionViewDataSoruce> dataSource;



- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

NS_ASSUME_NONNULL_END
@end
