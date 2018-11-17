//
//  ViewController.m
//  XDStarRatingScoreView
//
//  Created by 窦心东 on 2018/11/17.
//  Copyright © 2018 f2c. All rights reserved.
//

#import "ViewController.h"
#import "XDStarRatingScoreView.h"
@interface ViewController ()<XDStarRatingScoreViewDelegate>
@property (strong, nonatomic) XDStarRatingScoreView *starRatingScoreView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//第一种方法创建
//    self.starRatingScoreView = [[XDStarRatingScoreView alloc] initWithFrame:CGRectMake(30, 100, 160, 20) numberOfStars:5 withStarSelectedImageName:@"star_selected" andStarNormalImageName:@"star_normal"];
//    self.starRatingScoreView.defaultValue = 3;
//    self.starRatingScoreView.allowIncompleteStar = NO;
//    self.starRatingScoreView.hasAnimation = YES;
//    self.starRatingScoreView.delegate = self;
//    self.starRatingScoreView.userInteractionEnabled = NO;
//    [self.view addSubview:self.starRatingScoreView];
   //第二种方法创建
    self.starRatingScoreView = [[XDStarRatingScoreView alloc] initWithFrame:CGRectMake(30, 100, 160, 20) numberOfStars:5];
    self.starRatingScoreView.defaultValue = 4;
    self.starRatingScoreView.allowIncompleteStar = NO;
    self.starRatingScoreView.hasAnimation = YES;
    [self.starRatingScoreView configStarSelectedImageName:@"star_selected" andStarNormalImageName:@"star_normal"];
    self.starRatingScoreView.delegate = self;
    [self.view addSubview:self.starRatingScoreView];
    
    
    self.starRatingScoreView.starScoreVlueBlock = ^(XDStarRatingScoreView *starRatingScoreView, CGFloat scoreValue) {
        NSLog(@"%sstarRatingScoreView == %@\nscoreValue == %f",__func__,starRatingScoreView,scoreValue);
    };
    self.starRatingScoreView.starScorePercentBlock = ^(XDStarRatingScoreView *starRatingScoreView, CGFloat scorePercent) {
        NSLog(@"%sstarRatingScoreView == %@\nscorePercent == %f",__func__,starRatingScoreView,scorePercent);
    };
}
#pragma mark - XDStarRatingScoreViewDelegate
- (void)starRatingView:(XDStarRatingScoreView *)starRatingScoreView scroeValueDidChange:(CGFloat)scoreValue{
    NSLog(@"%sstarRatingScoreView == %@\nscoreValue == %f",__func__,starRatingScoreView,scoreValue);
}
- (void)starRatingView:(XDStarRatingScoreView *)starRatingScoreView scroePercentDidChange:(CGFloat)scorePercent{
    NSLog(@"%sstarRatingScoreView == %@\nscorePercent == %f",__func__,starRatingScoreView,scorePercent);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
