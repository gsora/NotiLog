#import "GSAppDelegate.h"
#import "GSRootViewController.h"

@implementation GSAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[UINavigationController alloc] initWithRootViewController:[[GSRootViewController alloc] init]];
	_window.rootViewController = _rootViewController;
	[_window makeKeyAndVisible];
}

- (void)dealloc {
	[_window release];
	[_rootViewController release];
	[super dealloc];
}

@end
