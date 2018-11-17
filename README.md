# XDStarRatingScoreView
XDStarRatingScoreView
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
