//
//  TrayViewController.h
//  ShapeCreator
//
//  Created by Benny Singer on 11/26/18.
//  Copyright © 2018 bzsinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrayView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrayViewController : UIViewController

- (instancetype)initWithTrayView:(TrayView *)trayView;

@end

NS_ASSUME_NONNULL_END
