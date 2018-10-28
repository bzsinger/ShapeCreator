//
//  WalkthroughViewController.h
//  ShapeCreator
//
//  Created by Benny Singer on 10/25/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkthroughView.h"

@interface WalkthroughViewController : UIViewController

- (instancetype)initWithWalkthroughView:(WalkthroughView *)walkthroughView;

- (void)showWalkthroughView;

@end

