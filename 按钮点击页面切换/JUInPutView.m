//
//  JUInPutView.m
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/24.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "JUInPutView.h"

@interface JUInPutView ()<UITextViewDelegate>
@property(nonatomic, strong) UIButton *changeButtton;

@property(nonatomic, strong) UIButton *sendButton;

@property(nonatomic, assign) CGFloat contentSizeHeight;

@property(nonatomic, strong) NSMutableAttributedString *attributeText;


@end



@implementation JUInPutView
//-(NSMutableAttributedString *)attributeText{
//    if (!_attributeText) {
//        _attributeText = [[NSMutableAttributedString alloc]initWithString:self.textView.text];
//    }
//    return _attributeText;
//}



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    
    self.textView = [[UITextView alloc]init];
    [self addSubview:self.textView];
    
    self.textView.delegate = self;
    
    
    self.changeButtton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.changeButtton];
    
    
    self.sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.sendButton addTarget:self action:@selector(buttonClicked) forControlEvents:(UIControlEventTouchUpInside)];

    [self addSubview:self.sendButton];
    
    
    
    self.textView.font = [UIFont systemFontOfSize:18];

    self.textView.scrollEnabled = NO;
    
    self.textView.backgroundColor = [UIColor grayColor];
    self.changeButtton.backgroundColor = [UIColor yellowColor];
    self.sendButton.backgroundColor = [UIColor redColor];
    
    
    return self;
}

-(void)buttonClicked{
    
    if (self.block) {
        self.block(self.textView.attributedText);
    }
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    
    self.changeButtton.frame = CGRectMake(0, 0, 35, height);
    

    
    
    CGSize newSize = [self.textView sizeThatFits:CGSizeMake(width-35-40, MAXFLOAT)];
    
    
    
    self.textView.frame = CGRectMake(35, height-newSize.height, width-35-40 , newSize.height);
    
    
    
    self.sendButton.frame = CGRectMake(CGRectGetMaxX(self.textView.frame), 0, width-CGRectGetMaxX(self.textView.frame), height);
   
}


- (void)textViewDidChange:(UITextView *)textView{
    

    [self setNeedsLayout];
    
    
    
//    NSLog(@"文字正在变化");
    
//    if (self.contentSizeHeight != textView.contentSize.height) {
//        self.contentSizeHeight = textView.contentSize.height;
//        [self setNeedsLayout];
//        NSLog(@"%f", self.contentSizeHeight);
//    }
}




-(void)inserEmoji:(Emoji *)emoji{
    
    if (emoji.type == EmojiTypeUnicode) {
        
        [self.textView insertText:emoji.emojiStr];
        
    }else{
        

        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.image = emoji.image;
        CGFloat lineHeight = self.textView.font.lineHeight;
        attachment.bounds = CGRectMake(0, -5, lineHeight, lineHeight);
        
        NSAttributedString *tempString = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithAttributedString:tempString];
        [attributeStr addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, 1)];
        
        
        //获取原来的文本
        NSMutableAttributedString *sourceString = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
        
        [sourceString replaceCharactersInRange:self.textView.selectedRange withAttributedString:attributeStr];
        self.attributeText = sourceString;
        NSUInteger location = self.textView.selectedRange.location;
        NSUInteger length = self.textView.selectedRange.length;
        self.textView.attributedText = sourceString;
        self.textView.selectedRange = NSMakeRange(location+1, length);
    }
    [self setNeedsLayout];
}


-(void)hhhhhhhhh{
    
    
    
}







@end
