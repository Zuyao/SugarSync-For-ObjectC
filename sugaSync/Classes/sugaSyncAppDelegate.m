//
//  sugaSyncAppDelegate.m
//  sugaSync
//
//  Created by zuyao on 12-5-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "sugaSyncAppDelegate.h"
#import "SugarSync.h"

@implementation sugaSyncAppDelegate

@synthesize window;
@synthesize userName = userName_;
@synthesize passWord = passWord_;

+ (sugaSyncAppDelegate *)sharedDelegate
{
    return (sugaSyncAppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    SugarSync *sugarSync = [[SugarSync alloc] init];
    [sugarSync loginWithUserName:@"fengmohuan@sina.com" PassWord:@"kingxh"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
