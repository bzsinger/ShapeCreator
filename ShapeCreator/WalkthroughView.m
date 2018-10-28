//
//  WalkthroughView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "WalkthroughView.h"

@interface WalkthroughView ()

@property (readwrite) UIButton *closeButton;

@end

@implementation WalkthroughView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];

        CGRect instructionFrame = CGRectMake(CGRectGetWidth(frame) / 8, CGRectGetHeight(frame) / 8, CGRectGetWidth(frame) * 3 / 4, CGRectGetHeight(frame) * 3 / 4);

        UIView *instructionView = [[UIView alloc] initWithFrame:instructionFrame];
        instructionView.layer.cornerRadius = 5.0;
        instructionView.backgroundColor = [UIColor blueColor];
        [self addSubview:instructionView];

        CGFloat buttonWidth = 30;
        self.closeButton = [[UIButton alloc] initWithFrame:
                             CGRectMake(CGRectGetWidth(frame) / 8 + CGRectGetWidth(instructionFrame) / 2 - buttonWidth / 2,
                                        CGRectGetHeight(frame) - CGRectGetHeight(frame) / 8 - buttonWidth * 3 / 2,
                                        buttonWidth,
                                        buttonWidth)];
        self.closeButton.backgroundColor = [UIColor redColor];
        [self addSubview:self.closeButton];
    }
    return self;
}

@end
