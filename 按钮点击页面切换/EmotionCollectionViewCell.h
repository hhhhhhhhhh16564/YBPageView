//
//  EmotionCollectionViewCell.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/23.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoji.h"
@interface EmotionCollectionViewCell : UICollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic, strong) Emoji *emoij;


@end
