//
//  WalkthroughView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "WalkthroughView.h"

@interface WalkthroughView () {
    UIView *instructionView;
}

@property (readwrite) UIButton *closeButton;

@end

@implementation WalkthroughView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        instructionView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:instructionView];

        self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:self.closeButton];
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

    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.closeButton sizeToFit];
    CGSize buttonSize = self.closeButton.frame.size;
    self.closeButton.frame = CGRectMake(CGRectGetWidth(self.frame) / 8 + CGRectGetWidth(instructionFrame) / 2 - buttonSize.width / 2,
                                        CGRectGetHeight(self.frame) - CGRectGetHeight(self.frame) / 8 - buttonSize.height * 3 / 2,
                                        buttonSize.width,
                                        buttonSize.height);
}

@end
