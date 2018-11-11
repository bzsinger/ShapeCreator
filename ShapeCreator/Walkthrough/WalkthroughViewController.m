//
//  WalkthroughViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "InstructionPaneView.h"
#import "InstructionPaneViewController.h"

@interface WalkthroughViewController () {
    InstructionPaneViewController *_instructionPaneViewController;
    WalkthroughView *_walkthroughView;
};

@end

@implementation WalkthroughViewController

- (instancetype)initWithWalkthroughView:(WalkthroughView *)walkthroughView {
    if (self = [super init]) {
        _instructionPaneViewController = [[InstructionPaneViewController alloc] initWithInstructionPaneView:walkthroughView.instructionPaneView];

        _walkthroughView = walkthroughView;
        [_walkthroughView setHidden:[[NSUserDefaults standardUserDefaults] boolForKey:@"walkthroughClosed"]];
        [_walkthroughView.closeButton addTarget:self action:@selector(hideWalkthroughView) forControlEvents:UIControlEventTouchUpInside];
        [_walkthroughView.nextButton addTarget:self action:@selector(nextInstructionSlide) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_walkthroughView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)hideWalkthroughView {
    _walkthroughView.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"walkthroughClosed"];
}

- (void)showWalkthroughView {
    _walkthroughView.hidden = NO;
}

- (void)nextInstructionSlide {
    CGPoint currentOffset = _walkthroughView.instructionPaneView.scrollView.contentOffset;
    CGFloat scrollViewFrameWidth = CGRectGetWidth(_walkthroughView.instructionPaneView.scrollView.frame);
    CGFloat scrollViewContentWidth = _walkthroughView.instructionPaneView.scrollView.contentSize.width;
    CGFloat nextInstructionX = currentOffset.x + scrollViewFrameWidth;
    if (nextInstructionX >= scrollViewContentWidth) {
        nextInstructionX = 0;
    }

    [UIView animateWithDuration:0.2 animations:^ {
        [self->_walkthroughView.instructionPaneView.scrollView setContentOffset:CGPointMake(nextInstructionX, currentOffset.y) animated:NO];
    }];
}

@end

