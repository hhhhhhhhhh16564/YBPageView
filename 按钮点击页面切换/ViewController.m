//
//  ViewController.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "YBTitleStytle.h"
#import "YBPageView.h"
#import "YBPageCollectionView.h"
#import "YBCollectionViewFlowLayout.h"
#import "EmotionCollectionViewCell.h"
#import "Emoji.h"
#import "JUInPutView.h"
@interface ViewController ()<YBCollectionViewFlowLayoutDelegate, YBPageCollectionViewDataSoruce>

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) JUInPutView *inputView;

@property(nonatomic, strong) UILabel *label;



@end

@implementation ViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self text2];
    [self setDataSource];
    
    self.label = [[UILabel alloc]init];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    self.label.font = [UIFont systemFontOfSize:18];
    
    self.label.frame = CGRectMake(20, 300, 300, 250);
    self.label.backgroundColor = [UIColor grayColor];
    
    

    
}

-(void)setDataSource{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ISEmojiList" ofType:@"plist"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:path];

    NSMutableArray *array1 = [NSMutableArray array];
    for (NSString *str  in array) {
        Emoji *emoji = [[Emoji alloc]init];
        emoji.emojiStr = str;
        emoji.type = EmojiTypeUnicode;
        [array1 addObject:emoji];
    }
    
    [self.dataArray addObject:array1];
    NSMutableArray *array2 = [NSMutableArray array];
    

    
    for (int i = 1; i <= 105 ; i++) {
        NSString *index  = [NSString stringWithFormat:@"%03d", i];
        NSString *imageName = [NSString stringWithFormat:@"%@@2x",index];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        Emoji *emoji = [[Emoji alloc]init];
        emoji.type = EmojiTypePng;
        emoji.image = image;
        [array2 addObject:emoji];
    }
    
    [self.dataArray addObject:array2];
}



-(void)text1{
    
    YBTitleStytle  *style = [[YBTitleStytle alloc]init];
    style.isScrollEndble = YES;
    NSArray *titleArray = @[@"语文", @"数学个地方官的双方各", @"化学生物", @"鹦鹉十多个电饭锅电饭锅", @"孙悟空发送分散", @"语文", @"数学", @"化学生物", @"鹦鹉", @"孙悟发顺丰萨达是否空"];
    //    titleArray = @[@"语文", @"数学", @"英语"];
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIViewController *Vc = [[UIViewController alloc]init];
        
        [childVcArray addObject:Vc];
    }
    
    CGRect rect = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    YBPageView *pageView = [[YBPageView alloc]initWithFrame:rect stytle:style titles:titleArray childVcs:childVcArray parentVc:self];
    
    [self.view addSubview:pageView];
  

}
-(void)text2{
    
    YBTitleStytle *style = [[YBTitleStytle alloc]init];
    style.isScrollEndble = NO;
    NSArray *titleArray = @[@"emoji",@"表情"];
    YBCollectionViewFlowLayout *layout = [[YBCollectionViewFlowLayout alloc]init];
    layout.flowoutDelegate = self;
    YBPageCollectionView *collectionView = [[YBPageCollectionView alloc]initWithFrame:CGRectMake(30, 0, 300, 250) titleStyle:style titles:titleArray isTitleTop:NO layout:layout];
    collectionView.dataSource = self;
    [collectionView registerClass:[EmotionCollectionViewCell class] forCellWithReuseIdentifier:@"1111"];
    [self.view addSubview:collectionView];
    
    self.inputView = [[JUInPutView alloc]init];
    self.inputView.frame = CGRectMake(0, 600, self.view.bounds.size.width, 35);
    [self.view addSubview:self.inputView];

__weak typeof(self) weakSelf = self;
    self.inputView.block = ^(id attribute){
        [weakSelf setLabelText:attribute];
    };
}


-(void)setLabelText:(NSMutableAttributedString *)attribute{
    
    self.label.attributedText = attribute;
    
    NSLog(@"%zd", attribute.length);
    

    [attribute enumerateAttributesInRange:NSMakeRange(0, attribute.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        NSLog(@"=================================");
        NSLog(@"%@", NSStringFromRange(range));
        NSLog(@"%@", attrs);
        NSLog(@"\n\n\n\n\n\n\n\n\n");
    
    
   }];
    
    
}

#pragma mark YBCollectionViewFlowLayoutDelegate
-(NSInteger)rowCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return 3;
}

-(NSInteger)columnCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return 7;
}


#pragma mark YBPageCollectionViewDataSoruce
- (__kindof UICollectionViewCell *)pageCollectionView:(YBPageCollectionView *)pagecollectionView  collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EmotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1111" forIndexPath:indexPath];

    cell.backgroundColor = RandomColor;
    
    
    Emoji *emoji = self.dataArray[indexPath.section][indexPath.row];
    
    cell.emoij = emoji;

    return cell;
    
}

- (NSInteger)numberOfSectionsInPageCollectionView:(YBPageCollectionView *)pageCollectionView{
    
    return self.dataArray.count;
}

-(NSInteger)pageCollectionView:(YBPageCollectionView *)pagecollectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}


-(void)pageCollectionView:(YBPageCollectionView *)pagecollectionVie didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Emoji *emoji = self.dataArray[indexPath.section][indexPath.row];
    
    [self insetEmoji:emoji];
    
    
    
}


-(void)insetEmoji:(Emoji *)emoji{
    [self.inputView inserEmoji:emoji];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
