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
    UILabel *singleTapLabel;
    UIImageView *doubleTapImageView;
    UILabel *doubleTapLabel;
    UIImageView *panGestureImageView;
    UILabel *panGestureLabel;
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

        singleTapImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:singleTapImageView];

        singleTapLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [singleTapLabel setText:@"Bring shape to front"];
        [instructionView addSubview:singleTapLabel];

        doubleTapImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:doubleTapImageView];

        doubleTapLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [doubleTapLabel setText:@"Delete shape"];
        [instructionView addSubview:doubleTapLabel];

        panGestureImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [instructionView addSubview:panGestureImageView];

        panGestureLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [panGestureLabel setText:@"Create shape"];
        [instructionView addSubview:panGestureLabel];
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
                                            CGRectGetHeight(singleTapImageFrame) + 30,
                                            100,
                                            100);
    [doubleTapImage drawInRect:doubleTapImageFrame];
    CGRect panGestureImageFrame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - 50,
                                            CGRectGetHeight(singleTapImageFrame) + CGRectGetHeight(doubleTapImageFrame) + 45,
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

    [singleTapLabel sizeToFit];
    CGSize singleTapLabelSize = singleTapLabel.frame.size;
    singleTapLabel.frame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - singleTapLabelSize.width / 2,
                                      CGRectGetHeight(singleTapImageFrame),
                                      singleTapLabelSize.width,
                                      singleTapLabelSize.height);

    [doubleTapLabel sizeToFit];
    CGSize doubleTapLabelSize = doubleTapLabel.frame.size;
    doubleTapLabel.frame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - doubleTapLabelSize.width / 2,
                                      CGRectGetHeight(singleTapImageFrame) + CGRectGetHeight(singleTapLabel.frame) + CGRectGetHeight(doubleTapImageFrame),
                                      doubleTapLabelSize.width,
                                      doubleTapLabelSize.height);

    [panGestureLabel sizeToFit];
    CGSize panGestureLabelSize = panGestureLabel.frame.size;
    panGestureLabel.frame = CGRectMake(CGRectGetWidth(instructionFrame) / 2 - panGestureLabelSize.width / 2,
                                      CGRectGetHeight(singleTapImageFrame) + CGRectGetHeight(singleTapLabel.frame) + CGRectGetHeight(doubleTapImageFrame) + CGRectGetHeight(doubleTapLabel.frame) + CGRectGetHeight(panGestureImageFrame),
                                      panGestureLabelSize.width,
                                      panGestureLabelSize.height);
}

@end
