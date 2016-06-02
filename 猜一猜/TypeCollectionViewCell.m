//
//  TypeCollectionViewCell.m
//  猜一猜
//
//  Created by zluof on 16/5/31.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import "TypeCollectionViewCell.h"

@implementation TypeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *view =
        [[UIImageView alloc]initWithFrame:(CGRect){15,10,60,60}];
        view.layer.cornerRadius = 30;
        view.layer.masksToBounds = YES;
        [self.contentView addSubview:view];
        self.iconView = view;
        
        UILabel *labeltit =
        [[UILabel alloc]initWithFrame:(CGRect){15,70,60,20}];
        labeltit.backgroundColor = [UIColor clearColor];
        labeltit.font = [UIFont systemFontOfSize:14];
        labeltit.textAlignment = NSTextAlignmentCenter;
        labeltit.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:labeltit];
        self.title = labeltit;
    }
    return self;
    
}

-(void)setIconViewImage:(UIImage *)image setTitle:(NSString *)title{
    self.iconView.image = image;
    self.title.text = title;
}
@end
