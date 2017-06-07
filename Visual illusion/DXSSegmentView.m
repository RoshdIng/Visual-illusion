//
//  DXSSegmentView.m
//  Visual illusion
//
//  Created by iOS on 2017/5/8.
//  Copyright © 2017年 123. All rights reserved.
//

#import "DXSSegmentView.h"
#import "Masonry.h"

@interface DXSSegmentView ()

@property (nonatomic, weak) UIView *highlightView;
@property (nonatomic, weak) UIView *highlightWithLabelView;

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *bottoms; ///<存放没有选中的label
@property (nonatomic, strong) NSMutableArray *highLights; ///<存放高亮的label

@end

@implementation DXSSegmentView

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles;
{
    if (self = [super init]) {
        _titles = titles.copy;
        _bottoms = [NSMutableArray arrayWithCapacity:titles.count];
        _highLights = [NSMutableArray arrayWithCapacity:titles.count];
        [self prepareForSubView];
    }
    return self;
}

- (void)prepareForSubView
{
    // highLightView 和 highlightWithLabelView做主要移动目标
    
    UIView *highlightView = [[UIView alloc] init];
    highlightView.clipsToBounds = YES;
    
    UIView *highlightLayerView = [[UIView alloc] init];
    highlightLayerView.layer.backgroundColor = [UIColor redColor].CGColor;
    highlightLayerView.layer.cornerRadius = 10;
    highlightLayerView.layer.masksToBounds = YES;
    [highlightView addSubview:highlightLayerView];
    self.highlightView = highlightView;
    
    UIView *highlightWithLabelView = [[UIView alloc] init];
    [highlightView addSubview:highlightWithLabelView];
    self.highlightWithLabelView = highlightWithLabelView;
    
    for (int index = 0; index < self.titles.count; index++) {
        UILabel *bottomLabel = [self labelWithTitle:self.titles[index] textColor:[UIColor blackColor]];
        UILabel *highlightsLabel = [self labelWithTitle:self.titles[index]textColor:[UIColor whiteColor]];
        
        [self addSubview:bottomLabel];
        [self.bottoms addObject:bottomLabel];
        [highlightWithLabelView addSubview:highlightsLabel];
        [self.highLights addObject:highlightsLabel];
    }
    [self addSubview:highlightView];
    
    [self.bottoms mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.bottoms mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(self);
    }];
    
    [self.highLights mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.highLights mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(highlightWithLabelView);
    }];
    
    [highlightView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.leading.and.bottom.equalTo(self);
        make.width.equalTo(self).dividedBy(_titles.count);
    }];
    
    [highlightLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(highlightView);
        make.leading.and.width.equalTo(highlightView);
    }];
    
    [highlightWithLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
}

- (void)layerViewDidAnimate:(CGFloat)offset
{
    [self.highlightView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.leading.offset(offset);
    }];
    
    [self.highlightWithLabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.offset(-offset);
        make.top.and.bottom.and.trailing.equalTo(self);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    CGFloat offset = touchPoint.x;
    int index = offset / (self.bounds.size.width / self.titles.count);
    offset = index * (self.bounds.size.width / self.titles.count);
    
    [self layerViewDidAnimate:offset];
}

- (UILabel *)labelWithTitle:(NSString *)title textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
