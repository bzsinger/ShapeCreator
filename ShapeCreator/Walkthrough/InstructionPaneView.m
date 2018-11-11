//
//  InstructionPaneView.m
//  ShapeCreator
//
//  Created by Benny Singer on 11/8/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "InstructionPaneView.h"

@interface InstructionPaneView ()

@property (readwrite) UIScrollView *scrollView;
@property (readwrite) UIPageControl *pageControl;
@property (readwrite) NSArray<InstructionView *> *instructionViews;

@end

@implementation InstructionPaneView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];

        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self addSubview:_pageControl];

        InstructionView *panGestureInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"pan_gesture.png"] text:@"Create"];
        [_scrollView addSubview:panGestureInstruction];

        InstructionView *singleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"single_tap_gesture.png"] text:@"Bring to front"];
        [_scrollView addSubview:singleTapInstruction];

        InstructionView *doubleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"double_tap_gesture.png"] text:@"Delete"];
        [_scrollView addSubview:doubleTapInstruction];

        _instructionViews = [NSArray<InstructionView*> arrayWithObjects:panGestureInstruction, singleTapInstruction, doubleTapInstruction, nil];

        [self bringSubviewToFront:_pageControl];
    }

    return self;
}

- (void)layoutSubviews {
    [_pageControl sizeToFit];
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - CGRectGetHeight(_pageControl.frame) - 10, CGRectGetWidth(_pageControl.frame), CGRectGetHeight(_pageControl.frame));

    _scrollView.frame = self.frame;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * [_instructionViews count], CGRectGetMinX(_pageControl.frame));

    for (int i = 0; i < [_instructionViews count]; i++) {
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) * i, 0, CGRectGetWidth(self.frame), CGRectGetMinX(_pageControl.frame));
        [_instructionViews objectAtIndex:i].frame = frame;
    }
}

@end
