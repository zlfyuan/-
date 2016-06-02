//
//  TypeCollectionview.m
//  猜一猜
//
//  Created by zluof on 16/5/30.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import "TypeCollectionview.h"
#import "TypeCollectionViewCell.h"
static NSString *identfier = @"cell";

@implementation TypeCollectionview
{
    NSMutableArray *_arrTypes;
}

-(TypeCollectionview *)initframe:(CGRect)frame {
    return [[TypeCollectionview alloc]initWithFrame:frame collectionViewLayout:[self layout]];
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self= [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        _arrTypes = [NSMutableArray new];
        self.backgroundColor = [UIColor clearColor];
        self.layer.contents = (id)[UIImage imageNamed:@"collectionviewBG.jpg"].CGImage;
        [self registerClass:[TypeCollectionViewCell class] forCellWithReuseIdentifier:identfier];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.typeArrs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    TypeCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:identfier forIndexPath:indexPath];
    UIImage *image;

    image =[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", _arrTypes[indexPath.row]]];
        if (!image) {
             image =  [UIImage imageNamed:@"icon-60.0@3x.png"];
        }
    
    [cell setIconViewImage:image setTitle:_arrTypes[indexPath.row]];
    return cell;
}

-(UICollectionViewFlowLayout*)layout{
    UICollectionViewFlowLayout *layout =
    [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(90, 90);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *type = _typeArrs[indexPath.row][_arrTypes[indexPath.row]];
    NSLog(@"%@",type);
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"NSNotificationCenterRefsh" object:self userInfo:@{@"type":type,@"title":_arrTypes[indexPath.row]}];
}


-(NSMutableArray *)typeArrs{
    if (!_typeArrs) {
        _typeArrs = [[NSMutableArray alloc]initWithObjects:
                     @{@"搞笑":@"gxmy"},
                     @{@"字谜":@"zmmy"},
                     @{@"成语":@"cymy"},
                     @{@"动物":@"dwmy"},
                     @{@"爱情":@"aqmy"},
                     @{@"灯谜":@"dmmy"},
                     @{@"人名":@"rmmy"},
                     @{@"地名":@"dimmy"},
                     @{@"词语":@"cy"},
                     @{@"用语":@"ry"},
                     @{@"儿童":@"etmy"},
                     @{@"物品":@"wpmy"},
                     @{@"植物":@"zwmy"},
                     @{@"名谜":@"jmmy"},
                     @{@"书报":@"sbmy"},
                     @{@"俗语":@"symy"},
                     @{@"药品":@"ypmy"},
                     @{@"音乐":@"yymy"},
                     @{@"称谓":@"cwmy"},
                     @{@"趣味":@"qtmy"},
                     @{@"精选":@"miyujingxuan"},
                     @{@"故事":@"mygs"},
                     @{@"脑筋急转弯":@"njmy"},
                     @{@"智力问答":@"zlmy"},
                     nil];
    }
    NSMutableArray *arrKeys  = [NSMutableArray new];
    for (int i =0; i<_typeArrs.count; i++) {
        NSArray *key = [[_typeArrs objectAtIndex:i] allKeys];
        for (NSString *str in key) {
            [arrKeys addObject:str];

        }
    }
    [_arrTypes addObjectsFromArray:arrKeys];
    return _typeArrs;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
