//
//  EmotionCollectionViewCell.m
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/23.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "EmotionCollectionViewCell.h"

@interface EmotionCollectionViewCell ()

@property(nonatomic, strong) UIButton *button;


@end

@implementation EmotionCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    
    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.titleLabel.font = [UIFont systemFontOfSize:18];
    self.button.titleLabel.textColor = [UIColor redColor];
    [self addSubview:self.button];
    
    self.button.userInteractionEnabled = NO;
//    self.button.imageView.userInteractionEnabled = NO;
//    self.button.titleLabel.userInteractionEnabled = NO;
    
    return self;
}

-(void)setEmoij:(Emoji *)emoij{
    
    _emoij = emoij;

    
    [self.button setTitle:nil forState:(UIControlStateNormal)];
    [self.button setImage:nil forState:(UIControlStateNormal)];
    
    if (_emoij.type == EmojiTypeUnicode) {
        [self.button setTitle:_emoij.emojiStr forState:(UIControlStateNormal)];
    }else{
        [self.button setImage:_emoij.image forState:(UIControlStateNormal)];
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.button.frame = self.bounds;

}

@end
