//
//  XDStarRatingScoreView.m
//  XDStarRatingScoreView
//
//  Created by 窦心东 on 2018/11/17.
//  Copyright © 2018 f2c. All rights reserved.
//

#import "XDStarRatingScoreView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"star_selected"
#define BACKGROUND_STAR_IMAGE_NAME @"star_normal"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface XDStarRatingScoreView ()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;
@property (nonatomic, copy)  NSString *starNormalImageName;//未选中时的星图
@property (nonatomic, copy)  NSString *starHalfImageName;//待实现 需配合 allowIncompleteStar = YES使用
@property (nonatomic, copy)  NSString *starSelectedImageName;//选中的星图
@property (nonatomic, assign) NSInteger numberOfStars;
@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@end

@implementation XDStarRatingScoreView

#pragma mark - Init Methods
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = DEFALUT_STAR_NUMBER;
        [self buildDataAndUI];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self buildDataAndUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars withStarSelectedImageName:(NSString *)starSelectedImageName andStarNormalImageName:(NSString *)starNormalImageName{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self buildDataAndUI];
        [self configStarSelectedImageName:starSelectedImageName andStarNormalImageName:starNormalImageName];
        
    }
    return self;
}

- (void)configStarSelectedImageName:(NSString *)starSelectedImageName andStarNormalImageName:(NSString *)starNormalImageName{
    _starSelectedImageName = starSelectedImageName;
    _starNormalImageName = starNormalImageName;
    self.backgroundStarView = [self createStarViewWithImage:_starNormalImageName?:BACKGROUND_STAR_IMAGE_NAME];
    [self addSubview:self.backgroundStarView];
    self.foregroundStarView = [self createStarViewWithImage:_starSelectedImageName?:FOREGROUND_STAR_IMAGE_NAME];
    [self addSubview:self.foregroundStarView];
}
#pragma mark - Private Methods

- (void)buildDataAndUI {
    _scorePercent = 1;//默认为1
    _hasAnimation = NO;//默认为NO
    _allowIncompleteStar = NO;//默认为NO
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
    self.scorePercent = starScore / self.numberOfStars;
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    if (!imageName) {
        NSLog(@"缺少图片");
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak XDStarRatingScoreView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRatingView:scroeValueDidChange:)]) {
        [self.delegate starRatingView:self scroePercentDidChange:scroePercent];
    }
    if (self.starScorePercentBlock) {
        self.starScorePercentBlock(self, scroePercent);
    }
    if ([self.delegate respondsToSelector:@selector(starRatingView:scroeValueDidChange:)]) {
        [self.delegate starRatingView:self scroeValueDidChange:scroePercent*self.numberOfStars];
    }
    if (self.starScoreVlueBlock) {
        self.starScoreVlueBlock(self, scroePercent*self.numberOfStars);
    }
    
    [self setNeedsLayout];
}
- (void)setDefaultValue:(CGFloat)defaultValue{
    _defaultValue = defaultValue;
    self.scorePercent = _defaultValue/self.numberOfStars;
    
}
- (void)setStarNormalImageName:(NSString *)starNormalImageName{
    _starNormalImageName = starNormalImageName;
    
}
- (void)setStarHalfImageName:(NSString *)starHalfImageName{
    _starHalfImageName = starHalfImageName;
}
- (void)setStarSelectedImageName:(NSString *)starSelectedImageName{
    _starSelectedImageName = starSelectedImageName;
    
}
@end

