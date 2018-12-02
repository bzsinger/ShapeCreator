//
//  TrayView.m
//  ShapeCreator
//
//  Created by Benny Singer on 11/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "TrayView.h"

@interface TrayView () {
    UIView *_indicatorView;

    UIButton *_saveButton;
    UIButton *_walkthroughButton;
};

@end

@implementation TrayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 5;

        _indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorView.backgroundColor = [UIColor grayColor];
        _indicatorView.layer.cornerRadius = 3;
        [self addSubview:_indicatorView];

        _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_saveButton setImage:[UIImage imageNamed:@"save_icon.png"] forState:UIControlStateNormal];
        [_saveButton addTarget:_delegate action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_saveButton];

        _walkthroughButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [_walkthroughButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_walkthroughButton addTarget:_delegate action:@selector(walkthroughButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_walkthroughButton];
    }
    return self;
}

- (void)layoutSubviews {
    _indicatorView.frame = CGRectMake(10, 10, 5, CGRectGetHeight(self.frame) - 20);

    [_saveButton sizeToFit];
    CGSize saveButtonSize = _saveButton.frame.size;
    _saveButton.frame = CGRectMake(CGRectGetMaxX(_indicatorView.frame) + 5,
                                   CGRectGetHeight(_indicatorView.frame) - 30,
                                   saveButtonSize.width,
                                   saveButtonSize.height);

    [_walkthroughButton sizeToFit];
    CGSize walkthroughButtonSize = _walkthroughButton.frame.size;
    _walkthroughButton.frame = CGRectMake(CGRectGetMaxX(_indicatorView.frame) + 5,
                                          30,
                                          walkthroughButtonSize.width,
                                          walkthroughButtonSize.height);
}

@end
