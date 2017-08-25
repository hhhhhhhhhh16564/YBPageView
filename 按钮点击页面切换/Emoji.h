//
//  Emoji.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/23.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, EmojiType){
    
    EmojiTypeUnKnow,
    EmojiTypeUnicode,
    EmojiTypePng
    
};

@interface Emoji : NSObject


@property(nonatomic, strong) NSString *emojiStr;

@property(nonatomic, strong) UIImage *image;

@property (nonatomic,assign) EmojiType type;

@end
