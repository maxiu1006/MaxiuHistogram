//
//  ViewController.m
//  MaxiuHistogram
//
//  Created by xiaoxh on 2019/8/1.
//  Copyright © 2019 maxiu. All rights reserved.
//

#import "ViewController.h"
#import "MaxiuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
#pragma mark - 单柱
- (IBAction)singleColumnClick:(UIButton *)sender {
    MaxiuViewController *vc = [[MaxiuViewController alloc] init];
    vc.chartsType = MaxiuChartsTypeSingleColumnType;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - 横柱
- (IBAction)horizontalColumnClick:(UIButton *)sender {
    MaxiuViewController *vc = [[MaxiuViewController alloc] init];
    vc.chartsType = MaxiuChartsTypeHorizontalColumnType;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

@end
