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

@interface ViewController ()<ZeroSDCycleViewDelegate>
@property(nonatomic,strong)ZeroSDCycleView *zeroSDCycleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestNetwork];
    [self zeroSDCycleView];
}

-(ZeroSDCycleView*)zeroSDCycleView{
    if (!_zeroSDCycleView) {
        _zeroSDCycleView = [ZeroSDCycleView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 190) delegate:self];
        [_zeroSDCycleView setShowPageControl:YES];
        [_zeroSDCycleView  setPageControlStyle:ZeroSDCycleViewPageContolStyleClassic];
        [_zeroSDCycleView setPageControlAliment:ZeroSDCycleViewPageContolAlimentCenter];
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
