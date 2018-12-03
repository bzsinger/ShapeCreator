//
//  CanvasView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _drawingView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_drawingView];
    }
    return self;
}

- (void)layoutSubviews {
    _drawingView.frame = self.frame;
}

@end
