//
//  ColorPickerView.h
//  ShapeCreator
//
//  Created by Benny Singer on 12/2/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorPickerView : UIView

@property (nonatomic, strong, readonly) UISlider *redSlider;
@property (nonatomic, strong, readonly) UISlider *greenSlider;
@property (nonatomic, strong, readonly) UISlider *blueSlider;

@end

NS_ASSUME_NONNULL_END
