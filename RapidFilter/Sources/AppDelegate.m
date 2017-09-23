//
//  AppDelegate.m
//  RapidFilter
//
//  Created by Yumenosuke Koukata on 10/25/14.
//  Copyright (c) 2014 Yumenosuke Koukata. All rights reserved.
//


#import "AppDelegate.h"
#import <UIColor-HexString/UIColor+HexString.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Debugging library: CocoaLumberjack
	[DDLog addLogger:[DDTTYLogger sharedInstance]]; // output logs to standard console
	[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexString:@"#FF313B"] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexString:@"#FFD53A"] backgroundColor:nil forFlag:LOG_FLAG_WARN];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexString:@"#4AA53B"] backgroundColor:nil forFlag:LOG_FLAG_INFO];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexString:@"#4763F9"] backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithHexString:@"#C7C7C7"] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];

#ifdef DEBUG
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
#endif

	return YES;
}

void uncaughtExceptionHandler(NSException *e) {
	DDLogError(@"%@\n%@\n%@", e.name, e.reason, e.callStackSymbols);
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
