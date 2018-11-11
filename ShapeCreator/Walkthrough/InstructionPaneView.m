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

        InstructionView *panGestureInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"pan_gesture.png"] text:@"Create"];
        InstructionView *singleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"single_tap_gesture.png"] text:@"Bring to front"];
        InstructionView *doubleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"double_tap_gesture.png"] text:@"Delete"];
        InstructionView *shakePhoneInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"shake_phone_gesture.png"] text:@"Shake phone to show walkthrough"];

        _instructionViews = [NSArray<InstructionView*> arrayWithObjects:panGestureInstruction, singleTapInstruction, doubleTapInstruction, shakePhoneInstruction, nil];

        for (int i = 0; i < [_instructionViews count]; i++) {
            [_scrollView addSubview:[_instructionViews objectAtIndex:i]];
        }

        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = [_instructionViews count];
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        [self addSubview:_pageControl];

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
