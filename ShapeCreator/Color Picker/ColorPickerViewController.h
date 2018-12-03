//
//  ColorPickerViewController.h
//  ShapeCreator
//
//  Created by Benny Singer on 12/3/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerView.h"

@class ColorPickerViewController;

@protocol ColorPickerDelegate <NSObject>

- (void)colorValuesChanged:(ColorPickerViewController *)colorPickerViewController;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ColorPickerViewController : UIViewController

@property (nonatomic, weak, readwrite) id<ColorPickerDelegate> delegate;

- (instancetype)initWithColorPickerView:(ColorPickerView *)colorPickerView;

- (void)setColorValues:(UIColor *)color;

- (UIColor *)getColorValues;

@end

NS_ASSUME_NONNULL_END
