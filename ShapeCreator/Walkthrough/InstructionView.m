//
//  InstructionView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/28/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "InstructionView.h"

@interface InstructionView () {
    UILabel *instructionLabel;
}

@property (readwrite) UIImageView *instructionImageView;

@end

@implementation InstructionView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)instructionImage text:(NSString *)instructionText {
    if (self = [super initWithFrame:frame]) {
        self.instructionImageView = [[UIImageView alloc] initWithImage:instructionImage];
        [self addSubview:self.instructionImageView];

        instructionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        instructionLabel.text = instructionText;
        [self addSubview:instructionLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.instructionImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width, self.frame.size.width));
    [self.instructionImageView.image drawInRect:self.instructionImageView.frame];
    UIGraphicsEndImageContext();

    [instructionLabel sizeToFit];
    instructionLabel.frame = CGRectMake(CGRectGetMidX(self.instructionImageView.frame) - CGRectGetWidth(instructionLabel.frame) / 2, CGRectGetMaxY(self.instructionImageView.frame) + 10, CGRectGetWidth(instructionLabel.frame), CGRectGetHeight(instructionLabel.frame));
}

@end
