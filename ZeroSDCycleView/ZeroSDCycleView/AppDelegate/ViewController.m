//
//  ViewController.m
//  ZeroSDCycleView
//
//  Created by ZeroSmile on 2017/9/7.
//  Copyright © 2017年 陈美安. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequestManager.h"
#import "ZeroSDCycleView.h"
#import "ZeroSDCAlertView.h"
#import "ZeroBubbleView.h"
#import "ZeroLineView.h"
#import "ZeroFireworkView.h"
#import "ZeroStarView.h"
#import "ZeroRainbowView.h"
@interface ViewController ()<ZeroSDCycleViewDelegate,ZeroSDCAlertDelegate>
@property(nonatomic,strong)ZeroSDCycleView *zeroSDCycleView;
@property(nonatomic,strong)ZeroSDCAlertView *zeroSDCAlertView;
@property(nonatomic,strong)ZeroBubbleView *zeroBubble;
@property (nonatomic, strong) ZeroLineView *leftMoveView;
@property (nonatomic, strong)ZeroFireworkView *zeroFirework;
@property (nonatomic, strong)ZeroStarView *zeroStarView;
@property (nonatomic, strong)ZeroRainbowView *zeroRainbow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              [self requestNetwork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self zeroSDCycleView];
        });
    });

}

-(ZeroRainbowView*)zeroRainbow{
    if (!_zeroRainbow) {
        // 彩虹
        _zeroRainbow = [[ZeroRainbowView alloc] initWithFrame:CGRectMake(0, 0, 240*kW_Scale, 240*kW_Scale) type:ZeroRainbowTypeDefault];
        _zeroRainbow.center = CGPointMake(self.view.bounds.size.width - 34*kW_Scale, 273*kH_Scale);
        [self.view addSubview: _zeroRainbow];
    }
    return _zeroRainbow;
}

-(ZeroStarView*)zeroStarView{
    if (!_zeroStarView) {
        //闪亮星星
        _zeroStarView = [[ZeroStarView alloc] initWithFrame:CGRectMake(85*kW_Scale, 175*kH_Scale, 12*kW_Scale, 12*kW_Scale) type:ZeroStarTypeStar];
       
        //旋转大星星 _zeroStarView = [[ZeroStarView alloc] initWithFrameMaxStrat:CGRectMake(75*kW_Scale, 200*kH_Scale, 32*kW_Scale, 32*kW_Scale)];
        [self.view addSubview:_zeroStarView];
    }
    return _zeroStarView;
}

-(ZeroFireworkView*)zeroFirework{
    if (!_zeroFirework) {
        // 烟花
        _zeroFirework= [[ZeroFireworkView alloc] initWithFrame:CGRectMake(60*kW_Scale, 100*kH_Scale, 35*kW_Scale, 35*kW_Scale) type:ZeroFireworkTypeVulgarLine];
        [self.view addSubview:_zeroFirework];
    }
    return _zeroFirework;
}

-(ZeroLineView*)leftMoveView{
    if (!_leftMoveView) {
        _leftMoveView = [[ZeroLineView alloc] initWithFrame:CGRectMake(40*kW_Scale, 150*kH_Scale, 260*kW_Scale, 20*kH_Scale) lineType:ZeroLineTypeAlimentLeft];
        [self.view addSubview:_leftMoveView];
    }
    return _leftMoveView;
}
-(ZeroBubbleView*)zeroBubble{
    if (!_zeroBubble) {
        _zeroBubble = [[ZeroBubbleView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_zeroBubble];
    }
    return _zeroBubble;
}


- (IBAction)click:(UIButton *)sender {
    _zeroSDCAlertView = [ZeroSDCAlertView zeroSDCAlertViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) delegate:self];
     [_zeroSDCAlertView setAnimationType:ZeroSDCAlertAnimationTypeCenter];
     [_zeroSDCAlertView showWithController:self];
}

- (IBAction)egg:(UIButton *)sender {

}


-(void)starLineAnimation{
    // 移除左移线条
    [_leftMoveView startLeftAnimation];
    // 右移线条
    ZeroLineView *right = [[ZeroLineView alloc] initWithFrame:CGRectMake(40*kW_Scale, 150*kH_Scale, 260*kW_Scale, 24*kH_Scale)lineType:ZeroLineTypeAlimentRigh];
    [self.view  addSubview:right];
}


-(ZeroSDCycleView*)zeroSDCycleView{
    if (!_zeroSDCycleView) {
        _zeroSDCycleView = [ZeroSDCycleView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 190) delegate:self];
        [_zeroSDCycleView setShowPageControl:YES];
        [_zeroSDCycleView  setPageControlStyle:ZeroSDCycleViewPageContolStyleAnimated];
        [_zeroSDCycleView setPageControlAliment:ZeroSDCycleViewPageContolAlimentRight];
        [self.view addSubview:self.zeroSDCycleView];
         [_zeroSDCycleView setAutoScrollTimeInterval:3.5f];
    }
    return _zeroSDCycleView;
}



-(void)requestNetwork{
    
    [[HttpRequestManager sharedManager]requestGetWithPath: URL_Subjects params:nil completed:^(BOOL ret, id obj) {
        if (ret) {
          NSLog(@"%@",obj);
            NSMutableArray*arraySource = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in obj) {
                NSString*banner = [[NSString alloc]init];
                banner =  [dic objectForKey:@"home_banner"];
                [arraySource addObject:banner];
            }
         
            [_zeroSDCycleView setArrayStringUrl:[arraySource copy]];
    
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
