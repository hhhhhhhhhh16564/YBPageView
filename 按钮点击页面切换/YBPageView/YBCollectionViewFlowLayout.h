//
//  YBCollectionViewFlowLayout.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/22.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBCollectionViewFlowLayout;

@protocol YBCollectionViewFlowLayoutDelegate <NSObject>

@required

// 每页有共有多少列
-(NSInteger)columnCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

// 每页共有多少行
-(NSInteger)rowCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;


@optional

//行间距
-(CGFloat)rowMarginInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

//列间距
-(CGFloat)columnMarginInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

// 上下左右距离
-(UIEdgeInsets)edgeInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

@end


@interface YBCollectionViewFlowLayout : UICollectionViewLayout

@property(nonatomic, weak) id<YBCollectionViewFlowLayoutDelegate> flowoutDelegate;

// 上下左右距离
-(UIEdgeInsets)inset;
//行的个数
-(NSInteger)rowCount;
//列的个数
-(NSInteger)columnCount;




@end
