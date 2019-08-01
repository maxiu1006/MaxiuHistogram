//
//  MaxiuViewController.h
//  MaxiuHistogram
//
//  Created by xiaoxh on 2019/8/1.
//  Copyright © 2019 maxiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MaxiuChartsType) {
    MaxiuChartsTypeSingleColumnType = 1,//单柱
    MaxiuChartsTypeHorizontalColumnType,//横柱
};
@interface MaxiuViewController : UIViewController
@property (nonatomic,assign) MaxiuChartsType chartsType;
@end


