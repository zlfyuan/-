//
//  TypeCollectionview.h
//  猜一猜
//
//  Created by zluof on 16/5/30.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeCollectionview : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *typeArrs;
-(TypeCollectionview *)initframe:(CGRect)frame;
@end
