//
//  GDataXMLAppDelegate.h
//  GDataXML
//
//  Created by Takatoshi -morimori- MORIYAMA on 10/08/18.
//  Copyright KRAY Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDataXMLViewController;

@interface GDataXMLAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GDataXMLViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GDataXMLViewController *viewController;

@end

