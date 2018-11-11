//
//  WalkthroughView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "WalkthroughView.h"
#import "InstructionView.h"

@interface WalkthroughView () {
    UIView *_instructionView;
}

@property (readwrite) InstructionPaneView *instructionPaneView;
@property (readwrite) UIButton *closeButton;
@property (readwrite) UIButton *nextButton;

@end

@implementation WalkthroughView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _instructionView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_instructionView];

        _instructionPaneView = [[InstructionPaneView alloc] initWithFrame:CGRectZero];
        [_instructionView addSubview:_instructionPaneView];

        _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [_instructionView addSubview:_closeButton];

        _nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_instructionView addSubview:_nextButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];

    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    CGFloat frameDivisor = 1.0 / 8.0;
    CGFloat dimensionMultiplier = 3.0 / 4.0;
    CGRect instructionFrame = CGRectMake(frameWidth * frameDivisor,
                                         frameHeight * frameDivisor,
                                         frameWidth * dimensionMultiplier,
                                         frameHeight * dimensionMultiplier);

    _instructionView.frame = instructionFrame;
    _instructionView.backgroundColor = [UIColor whiteColor];
    _instructionView.layer.cornerRadius = 5.0;
    _instructionView.layer.borderColor = [UIColor blackColor].CGColor;
    _instructionView.layer.borderWidth = 0.5;

    [_closeButton sizeToFit];
    CGSize closeButtonSize = _closeButton.frame.size;
    _closeButton.frame = CGRectMake(CGRectGetWidth(_instructionView.frame) - CGRectGetWidth(_closeButton.frame) - 15.0,
                                    CGRectGetHeight(_instructionView.frame) - CGRectGetHeight(_closeButton.frame) - 5,
                                    closeButtonSize.width,
                                    closeButtonSize.height);

    [_nextButton sizeToFit];
    CGSize nextButtonSize = _nextButton.frame.size;
    _nextButton.frame = CGRectMake(15,
                                   CGRectGetHeight(_instructionView.frame) - CGRectGetHeight(_nextButton.frame) - 5,
                                   nextButtonSize.width,
                                   nextButtonSize.height);

    _instructionPaneView.frame = CGRectMake(0, 20, CGRectGetWidth(instructionFrame), CGRectGetHeight(instructionFrame) - closeButtonSize.height - 10);
}

@end
