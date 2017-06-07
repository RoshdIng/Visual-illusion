//
//  ViewController.m
//  Visual illusion
//
//  Created by iOS on 2017/5/8.
//  Copyright © 2017年 123. All rights reserved.
//

#import "ViewController.h"
#import "DXSSegmentView.h"
#import "Masonry.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) DXSSegmentView *segmentView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DXSSegmentView *segmentView = [[DXSSegmentView alloc] initWithTitles:@[@"Hello", @"World", @"There", @"Fuck"]];
    [self.view addSubview:segmentView];
    self.segmentView = segmentView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 4, 0);
    [self.view addSubview:scrollView];
    
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(100);
        make.leading.and.trailing.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(segmentView.mas_bottom);
        make.leading.and.trailing.and.bottom.equalTo(self.view);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.segmentView layerViewDidAnimate:scrollView.contentOffset.x / 4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
