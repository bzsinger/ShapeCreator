//
//  InstructionPaneViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 11/8/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "InstructionPaneViewController.h"
#import "InstructionPaneView.h"

@interface InstructionPaneViewController ()

@property (readwrite) InstructionPaneView *instructionPaneView;

@end

@implementation InstructionPaneViewController

- (instancetype)initWithInstructionPaneView:(InstructionPaneView *)paneView {
    if (self = [super init]) {
        _instructionPaneView = paneView;
        _instructionPaneView.scrollView.delegate = self;
    }

    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _instructionPaneView.pageControl.currentPage = (NSInteger) roundf(scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame));
}

- (void)scrollToNextInstruction {
    CGPoint currentOffset = _instructionPaneView.scrollView.contentOffset;
    CGFloat scrollViewFrameWidth = CGRectGetWidth(_instructionPaneView.scrollView.frame);
    CGFloat scrollViewContentWidth = _instructionPaneView.scrollView.contentSize.width;
    CGFloat nextInstructionX = currentOffset.x + scrollViewFrameWidth;
    if (nextInstructionX >= scrollViewContentWidth) {
        nextInstructionX = 0;
    }

    [UIView animateWithDuration:0.2 animations:^ {
        [self->_instructionPaneView.scrollView setContentOffset:CGPointMake(nextInstructionX, currentOffset.y) animated:NO];
    }];
}

@end
