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
    InstructionView *panGestureInstruction;
    InstructionView *singleTapInstruction;
    InstructionView *doubleTapInstruction;
    UILabel *shakePhoneLabel;
}

@property (readwrite) UIButton *closeButton;

@end

@implementation WalkthroughView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        instructionView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:instructionView];

        self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [instructionView addSubview:self.closeButton];

        panGestureInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"pan_gesture.png"] text:@"Create"];
        [instructionView addSubview:panGestureInstruction];

        singleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"single_tap_gesture.png"] text:@"Bring to front"];
        [instructionView addSubview:singleTapInstruction];

        doubleTapInstruction = [[InstructionView alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"double_tap_gesture.png"] text:@"Delete"];
        [instructionView addSubview:doubleTapInstruction];

        shakePhoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        shakePhoneLabel.text = @"Shake phone to show this view";
        [instructionView addSubview:shakePhoneLabel];
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
    CGSize buttonSize = self.closeButton.frame.size;
    self.closeButton.frame = CGRectMake(CGRectGetWidth(instructionView.frame) / 2 - CGRectGetWidth(self.closeButton.frame) / 2,
                                        CGRectGetHeight(instructionView.frame) - CGRectGetHeight(self.closeButton.frame),
                                        buttonSize.width,
                                        buttonSize.height);

    CGFloat topBuffer = 20.0;
    CGFloat instructionWidth = CGRectGetWidth(instructionView.frame);
    CGFloat instructionHeight = 125.0;
    CGFloat fullInstructionHeight = 30.0 + instructionHeight;
    panGestureInstruction.frame = CGRectMake(0,
                                             topBuffer,
                                             instructionWidth,
                                             instructionHeight);
    singleTapInstruction.frame = CGRectMake(0,
                                            topBuffer + fullInstructionHeight,
                                            instructionWidth,
                                            instructionHeight);
    doubleTapInstruction.frame = CGRectMake(0,
                                            topBuffer + 2 * (fullInstructionHeight),
                                            instructionWidth,
                                            instructionHeight);

    [shakePhoneLabel sizeToFit];
    shakePhoneLabel.frame = CGRectMake(CGRectGetWidth(instructionView.frame) / 2 - CGRectGetWidth(shakePhoneLabel.frame) / 2,
                                       topBuffer + 3 * (fullInstructionHeight),
                                       CGRectGetWidth(shakePhoneLabel.frame),
                                       CGRectGetHeight(shakePhoneLabel.frame));
}

@end
