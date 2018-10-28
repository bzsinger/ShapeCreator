//
//  InstructionView.m
//  ShapeCreator
//
//  Created by Benny Singer on 10/28/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import "InstructionView.h"

@implementation InstructionView {
    UIImageView *instructionImageView;
    UILabel *instructionLabel;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)instructionImage text:(NSString *)instructionText {
    if (self = [super initWithFrame:frame]) {
        instructionImageView = [[UIImageView alloc] initWithImage:instructionImage];
        [self addSubview:instructionImageView];

        instructionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        instructionLabel.text = instructionText;
        [self addSubview:instructionLabel];
    }
    return self;
}

- (void)layoutSubviews {
    instructionImageView.frame = CGRectMake(20, 0, 125, 125);
    UIGraphicsBeginImageContext(CGSizeMake(125, 125));
    [instructionImageView.image drawInRect:instructionImageView.frame];
    UIGraphicsEndImageContext();

    [instructionLabel sizeToFit];
    instructionLabel.frame = CGRectMake(CGRectGetMaxX(instructionImageView.frame), CGRectGetMidY(instructionImageView.frame), CGRectGetWidth(instructionLabel.frame), CGRectGetHeight(instructionLabel.frame));
}

@end
