//
//  sugaSyncAppDelegate.h
//  sugaSync
//
//  Created by zuyao on 12-5-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sugaSyncAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    IBOutlet UITextField *userName_;
    IBOutlet UITextField *passWord_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, readonly) UITextField *userName;
@property (nonatomic, readonly) UITextField *passWord;

+ (sugaSyncAppDelegate *)sharedDelegate;

@end

