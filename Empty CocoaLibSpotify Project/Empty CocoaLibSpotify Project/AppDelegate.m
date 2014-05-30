//
//  AppDelegate.m
//  Empty CocoaLibSpotify Project
//
//  Created by Daniel Kennett on 02/08/2012.
/*
 Copyright (c) 2011, Spotify AB
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of Spotify AB nor the names of its contributors may
 be used to endorse or promote products derived from this software
 without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL SPOTIFY AB BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 This project is a simple project that does nothing but set up a basic CocoaLibSpotify
 application. This can be used to quickly get started with a new project that uses CocoaLibSpotify.
 */

#import "AppDelegate.h"
#import "CocoaLibSpotify.h"
#import "ViewController.h"

#define SP_LIBSPOTIFY_DEBUG_LOGGING 0

#include <stdint.h>
#include <stdlib.h>
const uint8_t g_appkey[] = {
	0x01, 0x26, 0x88, 0x11, 0xE0, 0x29, 0x37, 0x80, 0x17, 0x00, 0x41, 0x0B, 0x4E, 0x1F, 0x7A, 0xD4,
	0xB3, 0xA9, 0xEC, 0x82, 0x7A, 0x15, 0xFC, 0xF1, 0xA6, 0xA3, 0x72, 0xBF, 0x0E, 0xCE, 0xC0, 0xA1,
	0x4B, 0xC7, 0x3C, 0x4C, 0xA5, 0xB8, 0x4D, 0xC2, 0x10, 0xA2, 0x64, 0x25, 0xB1, 0x6E, 0xAC, 0x41,
	0xA3, 0x21, 0xDE, 0x81, 0x02, 0x73, 0xB7, 0x43, 0xD3, 0xB3, 0x36, 0xFE, 0x2F, 0xBB, 0x89, 0x1F,
	0xFC, 0x38, 0xAA, 0x82, 0xB1, 0xCE, 0x97, 0xD7, 0x3A, 0x64, 0x71, 0xCA, 0x19, 0xB3, 0xF8, 0x2A,
	0x10, 0xCC, 0x39, 0xE9, 0xA9, 0x5B, 0x06, 0x30, 0x60, 0x70, 0x52, 0xCA, 0x1E, 0x2B, 0x59, 0x94,
	0x04, 0x45, 0x7D, 0xF7, 0x06, 0xCF, 0xE6, 0x9F, 0x60, 0x7D, 0x03, 0x45, 0x75, 0xD6, 0x81, 0x16,
	0xC9, 0x15, 0x6B, 0xA6, 0x6F, 0xED, 0xF6, 0x7B, 0x4C, 0xAF, 0xD5, 0x26, 0x9E, 0xF5, 0x12, 0x0E,
	0xB8, 0x87, 0x6F, 0xD4, 0x31, 0xB7, 0xDB, 0x57, 0xE6, 0x02, 0xFF, 0xE4, 0xDF, 0x53, 0x55, 0x84,
	0x56, 0xAF, 0x79, 0x48, 0x6D, 0x60, 0x04, 0x6C, 0x1D, 0xB0, 0x1A, 0xD9, 0xFB, 0x99, 0x79, 0x8F,
	0xC8, 0x1B, 0xC6, 0xD1, 0xDB, 0xCF, 0x2E, 0x7F, 0xDD, 0xC5, 0x80, 0xF0, 0xE4, 0x6E, 0x91, 0xFA,
	0xF1, 0x7F, 0x8E, 0xA8, 0x53, 0x21, 0xF4, 0xC7, 0x0A, 0x83, 0xB7, 0x6B, 0xE5, 0xCB, 0xA8, 0x0B,
	0x37, 0x80, 0xE2, 0x6C, 0xC3, 0xD7, 0x60, 0x9F, 0xED, 0x3B, 0x56, 0xCE, 0x40, 0xEC, 0x29, 0x93,
	0x6C, 0x5A, 0xF1, 0x21, 0xE9, 0x8E, 0xF8, 0xE3, 0x62, 0xA2, 0x81, 0xDF, 0x2B, 0xE6, 0xD1, 0x71,
	0xFB, 0x55, 0x76, 0x49, 0x62, 0xD6, 0xA6, 0xCE, 0x04, 0x5F, 0x1B, 0x5F, 0x6F, 0x3D, 0x51, 0xAE,
	0xC9, 0x3F, 0x7D, 0x71, 0x2A, 0xED, 0x13, 0xE2, 0xBB, 0xB9, 0xD4, 0x63, 0x67, 0x6B, 0x0A, 0xE7,
	0x0D, 0x85, 0x0C, 0xCE, 0xF4, 0x4E, 0xD7, 0xB3, 0xAE, 0xE8, 0xF9, 0xCB, 0xCC, 0x7D, 0x96, 0x18,
	0x3E, 0xE3, 0x6C, 0x45, 0xF0, 0xF0, 0x7A, 0xE3, 0x86, 0x87, 0xB4, 0xA5, 0x28, 0x2C, 0x58, 0x56,
	0xB4, 0x55, 0x36, 0xDD, 0x77, 0x77, 0x7B, 0xF7, 0xA9, 0xAE, 0xAC, 0x7F, 0x0B, 0xFF, 0x72, 0x73,
	0x5E, 0x9B, 0xF6, 0x7D, 0xC6, 0x06, 0xF1, 0xC7, 0xA5, 0xA8, 0x41, 0x82, 0xB2, 0xA2, 0x7F, 0xCB,
	0xC7,
};
const size_t g_appkey_size = sizeof(g_appkey);

//#error Please get an appkey.c file from developer.spotify.com and remove this error before building.

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
	} else {
	    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
	}
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

	NSString *userAgent = [[[NSBundle mainBundle] infoDictionary] valueForKey:(__bridge NSString *)kCFBundleIdentifierKey];
	NSData *appKey = [NSData dataWithBytes:&g_appkey length:g_appkey_size];

	NSError *error = nil;
	[SPSession initializeSharedSessionWithApplicationKey:appKey
											   userAgent:userAgent
										   loadingPolicy:SPAsyncLoadingManual
												   error:&error];
	if (error != nil) {
		NSLog(@"CocoaLibSpotify init failed: %@", error);
		abort();
	}

	[[SPSession sharedSession] setDelegate:self];

	SPLoginViewController *controller = [SPLoginViewController loginControllerForSession:[SPSession sharedSession]];
	controller.allowsCancel = NO;
	// ^ To allow the user to cancel (i.e., your application doesn't require a logged-in Spotify user, set this to YES.
	[self.viewController presentModalViewController:controller animated:NO];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	__block UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
		[[UIApplication sharedApplication] endBackgroundTask:identifier];
	}];

	[[SPSession sharedSession] flushCaches:^{
		if (identifier != UIBackgroundTaskInvalid)
			[[UIApplication sharedApplication] endBackgroundTask:identifier];
	}];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark SPSessionDelegate Methods

-(void)sessionDidLoginSuccessfully:(SPSession *)aSession {
	// Called after a successful login.

	[SPAsyncLoading waitUntilLoaded:aSession timeout:kSPAsyncLoadingDefaultTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
		[SPAsyncLoading waitUntilLoaded:aSession.user timeout:kSPAsyncLoadingDefaultTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
			
			/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello %@!", aSession.user.displayName]
															message:@"You should ask the developer of this app to make it do something!"
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
			[alert show];*/
		}];
	}];
}

-(void)session:(SPSession *)aSession didFailToLoginWithError:(NSError *)error {
	// Called after a failed login. SPLoginViewController will deal with this for us.
}

-(void)sessionDidLogOut:(SPSession *)aSession; {
	// Called after a logout has been completed.
}

-(void)session:(SPSession *)aSession didGenerateLoginCredentials:(NSString *)credential forUserName:(NSString *)userName {

	// Called when login credentials are created. If you want to save user logins, uncomment the code below.

	/*
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *storedCredentials = [[defaults valueForKey:@"SpotifyUsers"] mutableCopy];

	if (storedCredentials == nil)
		storedCredentials = [NSMutableDictionary dictionary];

	[storedCredentials setValue:credential forKey:userName];
	[defaults setValue:storedCredentials forKey:@"SpotifyUsers"];
	 */
}

-(void)session:(SPSession *)aSession didEncounterNetworkError:(NSError *)error; {
	if (SP_LIBSPOTIFY_DEBUG_LOGGING != 0)
		NSLog(@"CocoaLS NETWORK ERROR: %@", error);
}

-(void)session:(SPSession *)aSession didLogMessage:(NSString *)aMessage; {
	if (SP_LIBSPOTIFY_DEBUG_LOGGING != 0)
		NSLog(@"CocoaLS DEBUG: %@", aMessage);
}

-(void)sessionDidChangeMetadata:(SPSession *)aSession; {
	// Called when metadata has been updated somewhere in the
	// CocoaLibSpotify object model. You don't normally need to do
	// anything here. KVO on the metadata you're interested in instead.
}

-(void)session:(SPSession *)aSession recievedMessageForUser:(NSString *)aMessage; {
	// Called when the Spotify service wants to relay a piece of information to the user.
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aMessage
													message:@"This message was sent to you from the Spotify service."
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

@end
