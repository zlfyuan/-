//
//  RiddleTableview.m
//  猜一猜
//
//  Created by zluof on 16/5/31.
//  Copyright © 2016年 zluof. All rights reserved.
//

#import "RiddleTableview.h"
#import "HomeViewController.h"
#import <AFNetworking/AFNetworking.h>
static NSString *identfier = @"cell";
@implementation RiddleTableview
{
    NSMutableArray *_riddleArrs;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource =self;
        [self RequestType:@"gxmy"];
        _riddleArrs = [NSMutableArray new];
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationCenterRefsh:) name:@"NSNotificationCenterRefsh" object:nil];
    }
    return self;
}

-(void)NSNotificationCenterRefsh:(NSNotification *)useInfo{
    [_riddleArrs removeAllObjects];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self RequestType:useInfo.userInfo[@"type"]];
        [self reloadData];
    });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _riddleArrs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"name_bg_blew.9.png"]];
    cell.backgroundView.contentMode = UIViewContentModeScaleToFill;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.numberOfLines = 0;
    [cell sizeToFit];
    cell.textLabel.text = _riddleArrs[indexPath.row][@"title"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexNumber(indexPath.row);
    self.answer(_riddleArrs[indexPath.row][@"answer"]);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.homeVC.navigationController.navigationBar.alpha = scrollView.contentOffset.y/100;
}


-(void)RequestType:(NSString *)type{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    __block NSDictionary *dic = [NSDictionary new];
    
    [manger GET:@"https://route.showapi.com/151-4"  parameters:@{@"showapi_appid":@"19192",@"showapi_sign":@"11ff3e127e75448b92b4c1a84658568a",@"typeId":type,@"page":@"2"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic[@"showapi_res_body"][@"pagebean"][@"contentlist"]);
        [_riddleArrs addObjectsFromArray:dic[@"showapi_res_body"][@"pagebean"][@"contentlist"]];
        [self reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface RiddleTableviewCell : UITableViewCell

@end

@implementation RiddleTableviewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
        label.text = @"hi啊哈和哇哦和我我哈佛我我化工我温和购物";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:label];
    }
    return  self;
}










@end