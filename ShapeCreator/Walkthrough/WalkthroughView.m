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
    InstructionView *singleTapInstruction;
    InstructionView *doubleTapInstruction;
    InstructionView *panGestureInstruction;
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
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];

    CGRect instructionFrame = CGRectMake(CGRectGetWidth(self.frame) / 8, CGRectGetHeight(self.frame) / 8, CGRectGetWidth(self.frame) * 3 / 4, CGRectGetHeight(self.frame) * 3 / 4);

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

    panGestureInstruction.frame = CGRectMake(0, 20, CGRectGetWidth(instructionView.frame), 125);
    singleTapInstruction.frame = CGRectMake(0, CGRectGetHeight(singleTapInstruction.frame) + 70, CGRectGetWidth(instructionView.frame), 125);
    doubleTapInstruction.frame = CGRectMake(0, CGRectGetHeight(singleTapInstruction.frame) + CGRectGetHeight(doubleTapInstruction.frame) + 120, CGRectGetWidth(instructionView.frame), 125);
}

@end
