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
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];

        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        self.pageControl.numberOfPages = 3;
        self.pageControl.currentPage = 0;
        self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self addSubview:self.pageControl];

        InstructionView *panGestureInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"pan_gesture.png"] text:@"Create"];
        [self.scrollView addSubview:panGestureInstruction];

        InstructionView *singleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"single_tap_gesture.png"] text:@"Bring to front"];
        [self.scrollView addSubview:singleTapInstruction];

        InstructionView *doubleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"double_tap_gesture.png"] text:@"Delete"];
        [self.scrollView addSubview:doubleTapInstruction];

        self.instructionViews = [NSArray<InstructionView*> arrayWithObjects:panGestureInstruction, singleTapInstruction, doubleTapInstruction, nil];

        [self bringSubviewToFront:self.pageControl];
    }

    return self;
}

- (void)layoutSubviews {
    [self.pageControl sizeToFit];
    self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - CGRectGetHeight(self.pageControl.frame) - 10, CGRectGetWidth(self.pageControl.frame), CGRectGetHeight(self.pageControl.frame));

    self.scrollView.frame = self.frame;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * [self.instructionViews count], CGRectGetMinX(self.pageControl.frame));

    for (int i = 0; i < [self.instructionViews count]; i++) {
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) * i, 0, CGRectGetWidth(self.frame), CGRectGetMinX(self.pageControl.frame));
        [self.instructionViews objectAtIndex:i].frame = frame;
    }
}

@end
