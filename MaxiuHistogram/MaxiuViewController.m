//
//  MaxiuViewController.m
//  MaxiuHistogram
//
//  Created by xiaoxh on 2019/8/1.
//  Copyright © 2019 maxiu. All rights reserved.
//

#import "MaxiuViewController.h"
#import "MaxiuHistogram-Swift.h"

//16进制GRB转UIColor
#define kCorlorFromHexcode(hexcode) [UIColor colorWithRed:((float)((hexcode & 0xFF0000) >> 16)) / 255.0 green:((float)((hexcode & 0xFF00) >> 8)) / 255.0 blue:((float)(hexcode & 0xFF)) / 255.0 alpha:1.0]


@interface MaxiuViewController ()
@property (nonatomic,strong)CombinedChartView *combine;
@property (nonatomic,strong)HorizontalBarChartView *horizontalBarChart;
@property (weak, nonatomic) IBOutlet UIView *chartView;

@end

@implementation MaxiuViewController
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.combine.hidden = YES;
    self.horizontalBarChart.hidden = YES;
    switch (self.chartsType) {
        case MaxiuChartsTypeSingleColumnType:{
            CombinedChartView *combine = [[CombinedChartView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.chartView.frame), CGRectGetHeight(self.chartView.frame))];
            [self.chartView addSubview:combine];
            self.combine = combine;
            self.combine.hidden = NO;
            NSMutableArray *keyArray = [[NSMutableArray alloc] initWithObjects:@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten",  nil];
            NSMutableArray *valueArray = [[NSMutableArray alloc] initWithObjects:@"10",@"12",@"2",@"5",@"15",@"1",@"12",@"5",@"18",@"9", nil];
            
            [self setCombineBarChart:self.combine xValues:keyArray yValues:valueArray  yTitle:@""];
        }break;
        case MaxiuChartsTypeHorizontalColumnType:{
            HorizontalBarChartView *horizontalBarChart = [[HorizontalBarChartView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.chartView.frame), CGRectGetHeight(self.chartView.frame))];
            [self.chartView addSubview:horizontalBarChart];
            self.horizontalBarChart = horizontalBarChart;
            self.horizontalBarChart.hidden = NO;
            
            NSMutableArray *keyArray = [[NSMutableArray alloc] initWithObjects:@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten", nil];
            NSMutableArray *valueArray = [[NSMutableArray alloc] initWithObjects:@"23",@"12",@"5",@"18",@"9",@"11",@"1",@"8",@"19",@"11", nil];
            
            [self setHorizontalBarChartView:self.horizontalBarChart xValues:keyArray yValues:valueArray  yTitle:@""];
        }break;
            
        default:
            break;
    }
}

#pragma mark - 单柱
- (void)setCombineBarChart:(CombinedChartView *)combineChart xValues:(NSArray *)xValues yValues:(NSArray *)yValues yTitle:(NSString *)yTitle{
    combineChart.drawOrder = @[@0];//CombinedChartDrawOrderBar,CombinedChartDrawOrderLine
    combineChart.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    combineChart.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    combineChart.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    combineChart.highlightFullBarEnabled = NO;
    combineChart.highlightPerDragEnabled = NO;
    combineChart.drawGridBackgroundEnabled = YES;
    combineChart.gridBackgroundColor = [UIColor whiteColor];
    combineChart.drawBordersEnabled = NO;//添加边框
    combineChart.rightAxis.enabled = NO;//隐藏右侧Y轴
    combineChart.leftAxis.drawZeroLineEnabled = YES;
    combineChart.legend.enabled = NO;//是否显示图例
    combineChart.userInteractionEnabled = YES;
    combineChart.dragEnabled = YES;//启用拖拽图表
    combineChart.highlightPerTapEnabled = YES;//取消单击高亮显示
    //交互设置
    combineChart.doubleTapToZoomEnabled = NO;//取消双击放大
    combineChart.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
    combineChart.scaleXEnabled = NO; // X 轴缩放
    combineChart.scaleYEnabled = NO; // Y 轴缩放 no取消 yes打开
    //    combineChart.pinchZoomEnabled = NO;//关闭触控放大
    //X轴设置
    ChartXAxis *xAxis = combineChart.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;// 网格绘制
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    xAxis.axisLineWidth = 0.9;
    xAxis.axisLineColor = kCorlorFromHexcode(0xBFBFBF);
    xAxis.labelTextColor = kCorlorFromHexcode(0x8C9FAD);
    xAxis.yOffset = 10;
    if (xValues.count<6) {
        xAxis.labelCount = xValues.count;
    }else{
        xAxis.labelCount = 6;
    }
    
    xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];
    xAxis.drawAxisLineEnabled = YES;// 是否显示轴线
    
    //左侧Y轴设置
    ChartYAxis *leftAxis = combineChart.leftAxis;
    leftAxis.spaceMin = 10;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.axisMinimum = 0.0f;
    leftAxis.axisLineColor = [UIColor clearColor];
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.gridLineDashLengths = @[@0.5f, @0.5f];//设置虚线样式的网格线
    leftAxis.gridColor = kCorlorFromHexcode(0x8C9FAD);//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    leftAxis.labelTextColor = kCorlorFromHexcode(0x8C9FAD);
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.barData = [self generateCombineBarData:yValues title1:yTitle];
    combineChart.data = data;
    [combineChart setVisibleXRangeMaximum:6];// 柱状图设置最大可见数（必须在柱状图有数据后设置才有效）
    
    xAxis.labelRotationAngle = 0;//倾斜度
    leftAxis.drawLabelsEnabled = YES;//显示左侧Y轴数据
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.maximumFractionDigits = 0;//默认3位 小数最多位数
    leftAxisFormatter.minimumIntegerDigits = 1;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.axisMinimum = data.xMin - 0.7f;
    xAxis.axisMaximum = data.xMax + 0.7f;
    
    combineChart.extraBottomOffset = 10;
    XYMarkerView *marker = [[XYMarkerView alloc]
                            initWithColor:kCorlorFromHexcode(0x1F3F59)
                            font: [UIFont systemFontOfSize:12.0]
                            textColor: UIColor.whiteColor
                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                            xAxisValueFormatter:combineChart.xAxis.valueFormatter];
    [marker setminimumDigitsWithMinFractionDigits:2 maxFractionDigits:2 minIntegerDigits:1 maxIntegerDigits:1];
    marker.chartView = combineChart;
    marker.minimumSize = CGSizeMake(40.f, 20.f);
    combineChart.marker = marker;
    [combineChart animateWithYAxisDuration:1.0];
    [combineChart notifyDataSetChanged];
    [combineChart.data notifyDataChanged];
}
- (BarChartData *)generateCombineBarData:(NSArray *)bar1Values title1:(NSString *)bar1Title
{
    NSMutableArray *bar1Entries = [NSMutableArray array];
    for (int i=0; i<bar1Values.count; i++) {
        CGFloat value = [bar1Values[i] floatValue];
        BarChartDataEntry *barEntry = [[BarChartDataEntry alloc] initWithX:i y:value];
        [bar1Entries addObject:barEntry];
    }
    BarChartDataSet *dataSet1 = [[BarChartDataSet alloc] initWithEntries:bar1Entries label:@""];
    
    dataSet1.colors = @[kCorlorFromHexcode(0x1890FF)];
    dataSet1.axisDependency = AxisDependencyLeft;
    dataSet1.drawValuesEnabled = YES;//是否在柱形图上面显示数值  No不显示
    BarChartData *data = [[BarChartData alloc] initWithDataSet:dataSet1];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    [data setValueTextColor:kCorlorFromHexcode(0x1F3F59)];
    data.barWidth = 0.6f;
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormatter setPositiveFormat:@"#0.00"];
    ChartDefaultValueFormatter *formatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:numFormatter];
    [data setValueFormatter:formatter];
    return data;
}
#pragma mark - 横柱
- (void)setHorizontalBarChartView:(HorizontalBarChartView *)chartView xValues:(NSArray *)xValues yValues:(NSArray *)yValues yTitle:(NSString *)yTitle
{
    chartView.doubleTapToZoomEnabled = NO;//取消双击放大
    chartView.chartDescription.enabled = NO;
    chartView.drawGridBackgroundEnabled = NO;//是否绘制网状格局背景(灰色那一块)
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:NO];//关闭缩放
    chartView.legend.enabled = NO;//是否显示图例
    chartView.rightAxis.enabled = NO;
    chartView.drawBarShadowEnabled = NO;
    chartView.drawValueAboveBarEnabled = YES;//是否在条形图顶端显示数值
    chartView.maxVisibleCount = 60;
    chartView.extraBottomOffset = 0;//距离底部的额外偏移
    chartView.extraTopOffset = 0;//距离顶部的额外偏移
    chartView.fitBars = YES;//统计图完全显示
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴label在底部显示
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];//X轴label文字大小
    xAxis.labelTextColor = kCorlorFromHexcode(0x1F3F59);//X轴label文字颜色
    xAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
    if (xValues.count<6) {
        xAxis.labelCount = xValues.count;
    }else{
        xAxis.labelCount = 6;
    }
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线（X轴就绘制竖线，Y轴绘制横线）
    xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];//X轴文字描述的内容
    
    ChartYAxis *leftAxis = chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.axisMinimum = 0.0;//Y轴最小值（不然不会从0开始）
    leftAxis.drawLabelsEnabled = NO;//隐藏左侧Y轴数据
    leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    /*网格线样式*/
    leftAxis.gridLineDashLengths = @[@0.5f, @0.5f];//设置虚线样式的网格线
    leftAxis.gridColor = kCorlorFromHexcode(0x8C9FAD);//Y轴网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启Y轴锯齿线
    
    ChartYAxis *rightAxis = chartView.rightAxis;
    rightAxis.axisLineColor = [UIColor clearColor];
    rightAxis.enabled = YES;//隐藏右边轴
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    rightAxis.labelTextColor = kCorlorFromHexcode(0x8C9FAD);
    [chartView animateWithYAxisDuration:2.5];//设置动画效果，可以设置X轴和Y轴的动画效果
    chartView.data = [self horizontalBarChartData:yValues title1:yTitle];
    [chartView setVisibleXRangeMaximum:6];// 柱状图设置最大可见数（必须在柱状图有数据后设置才有效）
    XYMarkerView *marker = [[XYMarkerView alloc]
                            initWithColor:kCorlorFromHexcode(0x1F3F59)
                            font: [UIFont systemFontOfSize:11.0]
                            textColor: UIColor.whiteColor
                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
                            xAxisValueFormatter:chartView.xAxis.valueFormatter];
    [marker setminimumDigitsWithMinFractionDigits:2 maxFractionDigits:4 minIntegerDigits:1 maxIntegerDigits:1];
    marker.chartView = chartView;
    marker.minimumSize = CGSizeMake(50.f, 20.f);
    chartView.marker = marker;
    [chartView notifyDataSetChanged];
    [chartView.data notifyDataChanged];
}
- (BarChartData*)horizontalBarChartData:(NSArray *)bar1Values title1:(NSString *)bar1Title
{
    NSMutableArray *bar1Entries = [NSMutableArray array];
    for (int i=0; i<bar1Values.count; i++) {
        BarChartDataEntry *barEntry = [[BarChartDataEntry alloc] initWithX:i y:[bar1Values[i] doubleValue]];
        [bar1Entries addObject:barEntry];
    }
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithEntries:bar1Entries label:@""];
    dataSet.colors = @[kCorlorFromHexcode(0x3FA7FF)];//统计图颜色,有几个颜色，图例就会显示几个标识
    dataSet.axisDependency = AxisDependencyLeft;
    dataSet.drawValuesEnabled = NO;//是否在柱形图上面显示数值  No不显示
    dataSet.drawIconsEnabled = NO; // 同时开启即可
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:dataSet];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    [data setValueTextColor:kCorlorFromHexcode(0x3AA0FF)];
    data.barWidth = 0.4f;//统计图宽占X轴的比例
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormatter setPositiveFormat:@"#0.00"];
    ChartDefaultValueFormatter *formatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:numFormatter];
    [data setValueFormatter:formatter];
    return data;
}

@end
