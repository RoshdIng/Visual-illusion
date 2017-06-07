//
//  DXSSegmentView.h
//  Visual illusion
//
//  Created by iOS on 2017/5/8.
//  Copyright © 2017年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXSSegmentView;

@protocol DXSSegmentViewDelegate <NSObject>

- (void)segmentView:(DXSSegmentView *)segmentView layerDidAnimateWithIndexOfOffset:(int)index;

@end

@interface DXSSegmentView : UIView

/**
 没被选中的文字颜色，默认是黑色
 */
@property (nonatomic, strong) UIColor *normalTextColor;

/**
 选中时的文字颜色，默认是白色
 */
@property (nonatomic, strong) UIColor *highlightTextColor;

/**
 移动layer的颜色，默认是红色
 */
@property (nonatomic, strong) UIColor *layerBackgroundColor;

@property (nonatomic, weak) id<DXSSegmentViewDelegate> delegate;

/**
 初始化
 
 @param titles 文字
 @return DXSSegmentView
 */
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles;

/**
 偏移方法
 
 @param offset 偏移值
 */
- (void)layerViewDidAnimate:(CGFloat)offset;

@end
