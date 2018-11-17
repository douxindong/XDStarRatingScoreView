# XDStarRatingScoreView
XDStarRatingScoreView
讲解：
```
#import <UIKit/UIKit.h>

@class XDStarRatingScoreView;
@protocol XDStarRatingScoreViewDelegate <NSObject>
@optional
- (void)starRatingView:(XDStarRatingScoreView *)starRatingScoreView scroePercentDidChange:(CGFloat)scorePercent;
- (void)starRatingView:(XDStarRatingScoreView *)starRatingScoreView scroeValueDidChange:(CGFloat)scoreValue;
@end
/** 返回评分值 */
typedef void(^StarScorePercentBlock)(XDStarRatingScoreView *starRatingScoreView,CGFloat scorePercent);
/** 返回评分个数 */
typedef void(^StarScoreValueBlock)(XDStarRatingScoreView *starRatingScoreView,CGFloat scoreValue);
@interface XDStarRatingScoreView : UIView
@property (nonatomic, assign) CGFloat defaultValue;//分值，范围为1--numberOfStars，默认为numberOfStars
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic,copy)  StarScorePercentBlock starScorePercentBlock;//返回评分值precent block
@property (nonatomic,copy) StarScoreValueBlock starScoreVlueBlock;//返回评分值value block
@property (nonatomic, weak) id<XDStarRatingScoreViewDelegate>delegate;//返回评分值需要实现delegate

/**
 初始化创建一个星级评分的视图
 
 @param frame 大小位置
 @param numberOfStars 一共显示几个星
 Need implementation configStarSelectedImageName:andStarNormalImageName:
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
- (void)configStarSelectedImageName:(NSString *)starSelectedImageName andStarNormalImageName:(NSString *)starNormalImageName;
/**
 初始化创建一个星级评分的视图
 
 @param frame 大小位置
 @param numberOfStars 一共显示几个星
 @param starSelectedImageName 选中
 @param starNormalImageName 未选中
 No need implementation configStarSelectedImageName:andStarNormalImageName:
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars withStarSelectedImageName:(NSString *)starSelectedImageName andStarNormalImageName:(NSString *)starNormalImageName;

@end

```
示例：
```
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


```
