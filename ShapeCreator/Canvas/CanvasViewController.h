//
//  CanvasViewController.h
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasView.h"
#import "ColorPickerViewController.h"

@interface CanvasViewController : UIViewController <ColorPickerDelegate>

- (instancetype)initWithCanvasView:(CanvasView *)canvasView;

- (UIImage *)getCanvasSnapshot;

@end
