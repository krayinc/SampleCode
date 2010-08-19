//
//  UIDevice_extensionAppDelegate.h
//  UIDevice-extension
//
//  Created by Takatoshi -morimori- MORIYAMA on 10/08/18.
//  Copyright KRAY Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice_extensionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end

