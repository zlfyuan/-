//
//  TypeCollectionViewCell.h
//  猜一猜
//
//  Created by zluof on 16/5/31.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel  *title;
-(void)setIconViewImage:(UIImage *)image setTitle:(NSString *)title;
@end
