//
//  JUInPutView.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/24.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoji.h"
@interface JUInPutView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic, strong) UITextView *textView;

-(void)inserEmoji:(Emoji *)emoji;

@property (nonatomic,copy) void(^block)(id) ;


@end
