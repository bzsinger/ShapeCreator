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
    UIView *instructionView;
}

@property (readwrite) InstructionPaneView *instructionPaneView;
@property (readwrite) UIButton *closeButton;
@property (readwrite) UIButton *nextButton;

@end

@implementation WalkthroughView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        instructionView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:instructionView];

        self.instructionPaneView = [[InstructionPaneView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:self.instructionPaneView];

        self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [instructionView addSubview:self.closeButton];

        self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [instructionView addSubview:self.nextButton];
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

    instructionView.frame = instructionFrame;
    instructionView.backgroundColor = [UIColor whiteColor];
    instructionView.layer.cornerRadius = 5.0;
    instructionView.layer.borderColor = [UIColor blackColor].CGColor;
    instructionView.layer.borderWidth = 0.5;

    [self.closeButton sizeToFit];
    CGSize closeButtonSize = self.closeButton.frame.size;
    self.closeButton.frame = CGRectMake(CGRectGetWidth(instructionView.frame) - CGRectGetWidth(self.closeButton.frame) - 15.0,
                                        CGRectGetHeight(instructionView.frame) - CGRectGetHeight(self.closeButton.frame) - 5,
                                        closeButtonSize.width,
                                        closeButtonSize.height);

    [self.nextButton sizeToFit];
    CGSize nextButtonSize = self.nextButton.frame.size;
    self.nextButton.frame = CGRectMake(15,
                            CGRectGetHeight(instructionView.frame) - CGRectGetHeight(self.nextButton.frame) - 5,
                            nextButtonSize.width,
                            nextButtonSize.height);

    self.instructionPaneView.frame = CGRectMake(0, 20, CGRectGetWidth(instructionFrame), CGRectGetHeight(instructionFrame) - closeButtonSize.height - 10);
}

@end
