//
//  ColorPickerViewController.m
//  ShapeCreator
//
//  Created by Benny Singer on 12/3/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "ColorPickerViewController.h"

@interface ColorPickerViewController () {
    ColorPickerView *_colorPickerView;
}

@end

@implementation ColorPickerViewController

- (instancetype)initWithColorPickerView:(ColorPickerView *)colorPickerView {
    if (self = [super init]) {
        _colorPickerView = colorPickerView;
        [_colorPickerView.redSlider addTarget:self action:@selector(redSliderValueChanged) forControlEvents:UIControlEventValueChanged];
        [_colorPickerView.greenSlider addTarget:self action:@selector(greenSliderValueChanged) forControlEvents:UIControlEventValueChanged];
        [_colorPickerView.blueSlider addTarget:self action:@selector(blueSliderValueChanged) forControlEvents:UIControlEventValueChanged];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        [_colorPickerView addGestureRecognizer:tapGestureRecognizer];
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
        [_colorPickerView addGestureRecognizer:panGestureRecognizer];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
        [_colorPickerView addGestureRecognizer:longPressGestureRecognizer];
    }
    return self;
}

- (void)redSliderValueChanged {
    _colorPickerView.redSlider.minimumTrackTintColor = [[UIColor alloc] initWithRed:_colorPickerView.redSlider.value green:0 blue:0 alpha:1];
    [_delegate colorValuesChanged:self];
}

- (void)greenSliderValueChanged {
    _colorPickerView.greenSlider.minimumTrackTintColor = [[UIColor alloc] initWithRed:0 green:_colorPickerView.greenSlider.value blue:0 alpha:1];
    [_delegate colorValuesChanged:self];
}

- (void)blueSliderValueChanged {
    _colorPickerView.blueSlider.minimumTrackTintColor = [[UIColor alloc] initWithRed:0 green:0 blue:_colorPickerView.blueSlider.value alpha:1];
    [_delegate colorValuesChanged:self];
}

- (void)setColorValues:(UIColor *)color {
    const CGFloat *colorComponents = CGColorGetComponents(color.CGColor);
    _colorPickerView.redSlider.value = colorComponents[0];
    _colorPickerView.greenSlider.value = colorComponents[1];
    _colorPickerView.blueSlider.value = colorComponents[2];
}

- (UIColor *)getColorValues {
    UIColor *currentColor = [[UIColor alloc] initWithRed:_colorPickerView.redSlider.value green:_colorPickerView.greenSlider.value blue:_colorPickerView.blueSlider.value alpha:1];
    return currentColor;
}

@end
