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
    UIImageView *singleTapImageView;
    UIImageView *doubleTapImageView;
    UIImageView *panGestureImageView;
}

@property (readwrite) UIButton *closeButton;

@end

@implementation WalkthroughView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        instructionView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:instructionView];

        self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [instructionView addSubview:self.closeButton];

        singleTapImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:singleTapImageView];

        doubleTapImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:doubleTapImageView];

        panGestureImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:panGestureImageView];
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
    self.closeButton.frame = CGRectMake(CGRectGetWidth(instructionView.frame) / 2 - CGRectGetWidth(self.closeButton.frame) / 2,
                                        CGRectGetHeight(instructionView.frame) - CGRectGetHeight(self.closeButton.frame),
                                        buttonSize.width,
                                        buttonSize.height);

    UIImage *singleTapImage = [UIImage imageNamed:@"single_tap_gesture.png"];
    UIImage *doubleTapImage = [UIImage imageNamed:@"double_tap_gesture.png"];
    UIImage *panGestureImage = [UIImage imageNamed:@"pan_gesture.png"];

    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    CGRect singleTapImageFrame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - 50,
                                            0,
                                            100,
                                            100);
    [singleTapImage drawInRect:singleTapImageFrame];
    CGRect doubleTapImageFrame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - 50,
                                            CGRectGetHeight(singleTapImageFrame),
                                            100,
                                            100);
    [doubleTapImage drawInRect:doubleTapImageFrame];
    CGRect panGestureImageFrame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - 50,
                                            CGRectGetHeight(singleTapImageFrame) + CGRectGetHeight(doubleTapImageFrame),
                                            100,
                                            100);
    [panGestureImage drawInRect:panGestureImageFrame];
    UIGraphicsEndImageContext();

    singleTapImageView.frame = singleTapImageFrame;
    [singleTapImageView setImage:singleTapImage];

    doubleTapImageView.frame = doubleTapImageFrame;
    [doubleTapImageView setImage:doubleTapImage];

    panGestureImageView.frame = panGestureImageFrame;
    [panGestureImageView setImage:panGestureImage];
}

@end
