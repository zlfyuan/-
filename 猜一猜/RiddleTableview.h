//
//  RiddleTableview.h
//  猜一猜
//
//  Created by zluof on 16/5/31.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;
@interface RiddleTableview : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)HomeViewController *homeVC;
@property (nonatomic,copy)void(^indexNumber)(NSInteger number);
@property (nonatomic,copy)void (^answer)(NSString *answer);
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@end
