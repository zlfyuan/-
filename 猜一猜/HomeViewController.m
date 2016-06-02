//
//  HomeViewController.m
//  猜一猜
//
//  Created by zluof on 16/5/30.
//  Copyright © 2016年 zluof. All rights reserved.
//

#define Kwidth self.view.frame.size.width
#define Hheight self.view.frame.size.height
#import "HomeViewController.h"
#import "TypeCollectionview.h"
#import "RiddleTableview.h"
@interface HomeViewController ()
{
    UIView *glissadeView;
    UILabel *view;
    RiddleTableview *riddleTableview;
    NSString *answers;
    NSString *tit;
    UILabel *titl;
}
@property (nonatomic, retain)UILabel *riddle;
@property (nonatomic, retain)UILabel *answer;
@end

@implementation HomeViewController

#pragma mark---点击事件
-(void)glissadeBut:(UIButton *)glissade{
    
    [UIView animateWithDuration:0.5 animations:^{
        if (!glissade.selected) {
            glissadeView.frame = CGRectMake(0, 64, 100, self.view.frame.size.height-128);
            glissade.frame = CGRectMake(10+90, self.view.center.y, 40, 40);
            
            riddleTableview.frame = CGRectMake(20+80, 64, Kwidth-40, Hheight-128);
        }else{
            glissadeView.frame = CGRectMake(-100, 64, 100, self.view.frame.size.height-128);
            glissade.frame = CGRectMake(-10, self.view.center.y, 40, 40);
            riddleTableview.frame = CGRectMake(20, 64, Kwidth-40, Hheight-128);
        }
    } completion:^(BOOL finished) {
        glissade.selected = !glissade.selected;
    }];
   
}
-(void)NSNotificationCenterRefsh:(NSNotification *)useInfo{
  
    dispatch_async(dispatch_get_main_queue(), ^{
      self.title = useInfo.userInfo[@"title"];
        titl.text = self.title;
    });
}

#pragma mark---UI控件
-(void)setUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationCenterRefsh:) name:@"NSNotificationCenterRefsh" object:nil];
    self.title = @"搞笑";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (id) [UIImage imageNamed:@"background.jpg"].CGImage;
    
    riddleTableview = [[RiddleTableview alloc]initWithFrame:CGRectMake(20, 64, Kwidth-40, Hheight-128) style:UITableViewStylePlain];
    riddleTableview.homeVC = self;
    riddleTableview.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.view addSubview:riddleTableview];
    
    titl =
    [[UILabel alloc]initWithFrame:(CGRect){Kwidth/3-20,Hheight-50,163,50}];
    titl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sort_bg"]];
    titl.textAlignment = NSTextAlignmentCenter;
    titl.font = [UIFont systemFontOfSize:30];
    titl.text = self.title;
    [self.view addSubview:titl];
    
    view = [[UILabel alloc]init];
    view.frame = (CGRect){Kwidth/3-40,Hheight/4,50,50};
    view.layer.cornerRadius = 25;
    view.layer.masksToBounds = YES;
    view.textAlignment = NSTextAlignmentCenter;
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"collectionviewBG.jpg"]];
    view.numberOfLines = 0;
    [view sizeToFit];
    [self.view addSubview:view];
    answers = [NSString new];
   [riddleTableview setAnswer:^(NSString *answer) {
       answers = answer;
   }];
    __block typeof (self) vc = self;
    __block typeof (view) vi = view;
    [riddleTableview setIndexNumber:^(NSInteger number) {
        [vc viewlayer:vi.layer];
    }];
  
}

-(void)glissade{
    
    UIButton *glissadeBut = [[UIButton alloc]initWithFrame:CGRectMake(-10, self.view.center.y, 40, 40)];
    glissadeBut.alpha = 0.5;
    [glissadeBut addTarget:self action:@selector(glissadeBut:) forControlEvents:UIControlEventTouchUpInside];
    [glissadeBut setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    [glissadeBut setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateHighlighted];
    [self.view addSubview:glissadeBut];
    
    glissadeView = [[UIView alloc]initWithFrame:CGRectMake(-100, 64, 100, self.view.frame.size.height-128)];
    glissadeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:glissadeView];
    
    TypeCollectionview *typeView = [[TypeCollectionview alloc]initframe:CGRectMake(5, 5, 90, self.view.frame.size.height-128-10)];
    [glissadeView addSubview:typeView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self glissade];

}



-(void)viewlayer:(CALayer*)layer{
    view.hidden = NO;
    CGFloat H = self.view.frame.size.height;
    CGFloat W = self.view.frame.size.width;
    CGFloat X = 0.0;
    CGFloat Y = 0.0;
    for (int i=0; i<W; i++) {
        X = arc4random() %(int)W;
    }

    for (int i=0; i<H; i++) {
        Y = arc4random() %(int)H;
    }

    CABasicAnimation *basic =
    [CABasicAnimation animationWithKeyPath:@"position"];
    basic.delegate = self;
    basic.duration = 2.0;
    basic.repeatCount = 1;
    basic.fromValue = [NSValue valueWithCGPoint:(CGPoint){X,Y}];
    basic.toValue = [NSValue valueWithCGPoint:(CGPoint){layer.position.x,layer.position.y}];
    [layer addAnimation:basic forKey:@"basic"];
    

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
 
    sleep(5);
    view.frame =  (CGRect){Kwidth/3-40,Hheight/4,50,50};
    view.layer.cornerRadius = 25;
    view.hidden = YES;
}

-(void)animationDidStart:(CAAnimation *)anim{
    view.text = answers;
    view.frame =  (CGRect){Kwidth/3-40,Hheight/4,250,50};
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
