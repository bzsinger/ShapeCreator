//
//  ColorPickerView.m
//  ShapeCreator
//
//  Created by Benny Singer on 12/2/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "ColorPickerView.h"

@interface ColorPickerView ()

@property (readwrite) UISlider *redSlider;
@property (readwrite) UISlider *greenSlider;
@property (readwrite) UISlider *blueSlider;

@end

@implementation ColorPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _redSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _redSlider.minimumTrackTintColor = [UIColor redColor];
        [self addSubview:_redSlider];
        
        _greenSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _greenSlider.minimumTrackTintColor = [UIColor greenColor];
        [self addSubview:_greenSlider];

        _blueSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _blueSlider.minimumTrackTintColor = [UIColor blueColor];
        [self addSubview:_blueSlider];

        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat buffer = 10;
    _redSlider.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, 30);
    _greenSlider.frame = CGRectMake(5, CGRectGetMaxY(_redSlider.frame) + buffer, CGRectGetWidth(self.frame) - 10, 30);
    _blueSlider.frame = CGRectMake(5, CGRectGetMaxY(_greenSlider.frame) + buffer, CGRectGetWidth(self.frame) - 10, 30);
}

@end
