//
//  InstructionView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/28/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "InstructionView.h"

@interface InstructionView () {
    UILabel *_instructionLabel;
}

@property (readwrite) UIImageView *instructionImageView;

@end

@implementation InstructionView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)instructionImage text:(NSString *)instructionText {
    if (self = [super initWithFrame:frame]) {
        _instructionImageView = [[UIImageView alloc] initWithImage:instructionImage];
        [self addSubview:_instructionImageView];

        _instructionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _instructionLabel.text = instructionText;
        [self addSubview:_instructionLabel];
    }
    return self;
}

- (void)layoutSubviews {
    _instructionImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width, self.frame.size.width));
    [_instructionImageView.image drawInRect:_instructionImageView.frame];
    UIGraphicsEndImageContext();

    [_instructionLabel sizeToFit];
    _instructionLabel.frame = CGRectMake(CGRectGetMidX(_instructionImageView.frame) - CGRectGetWidth(_instructionLabel.frame) / 2, CGRectGetMaxY(_instructionImageView.frame) + 10, CGRectGetWidth(_instructionLabel.frame), CGRectGetHeight(_instructionLabel.frame));
}

@end
