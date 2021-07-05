//
//  AppDelegate.m
//  AuthorizationApp
//
//  Created by Таня Василёнок on 4.07.21.
//

#import "AppDelegate.h"
#import "AuthorizationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    AuthorizationViewController *authorizationVC = [[AuthorizationViewController alloc] init];
    [window setRootViewController:authorizationVC];
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle





@end
