/*
 * NotiLog
 *
 * Written by Gianguido (gsora) Sorà
 * Twitter: @gsora_
 *
 * MIT License.
 */

#include <BulletinBoard/BBBulletin.h>
#include <BulletinBoard/BBServer.h>
#import "Notification.h"
#import "Db.h"

static NSString *TWEAK_SETTINGS_PATH = @"/User/Library/Preferences/xyz.gsora.notilog.plist";
#define SAVED_STRING (CFStringRef)@"xyz.gsora.notilog.saved"

/*
 * Whether the tweak should be enabled or not
 */
static bool enabled;

/*
 * This function load preferences into instance variables.
 */
static void loadPrefs() {
	NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:TWEAK_SETTINGS_PATH];
	enabled = [[settings objectForKey:@"enabled"] boolValue];
}

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	loadPrefs();
	HBLogDebug(@"prefs updated! new value of 'enabled': %d", enabled);
}

/*
 * Tweak constructor!
 *
 * It loads the preferences by calling loadPrefs(), and sets up a notification observer to update the tweak's preferencese at runtime.
 */
%ctor {
	[[Db sharedInstance] createDB];
	loadPrefs();
	CFNotificationCenterAddObserver(
			CFNotificationCenterGetDarwinNotifyCenter(), 
			NULL, 
			notificationCallback, 
			SAVED_STRING, 
			NULL, 
			CFNotificationSuspensionBehaviorCoalesce
			);

}

%hook BBServer

-(void)publishBulletin:(BBBulletin *)bulletin destinations:(unsigned int)arg2 alwaysToLockScreen:(BOOL)arg3 {
	if(enabled) {
		HBLogDebug(@"New notification incoming!");
		HBLogDebug(@"Message: %@", [bulletin message]);
		HBLogDebug(@"Date: %@", [bulletin date]);

		// if we have no date, it's not for us
		if(!([bulletin date] == nil)) {
			// strange thing needed because NSDate doesn't support simple thing as [object year] (ffs);
			NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[bulletin date]];

			// object to serialize
			Notification *n = [[Notification alloc] initWithMessage:[bulletin message] bulletinID:[bulletin bulletinID] title:[bulletin title] subtitle:[bulletin subtitle] section:[bulletin section] date:[NSString stringWithFormat:@"%lu-%lu-%lu", (long)[components year], (long)[components month], (long)[components day]]];
			int ret = [[Db sharedInstance] addEntry:n];
			HBLogDebug(@"Sqlite3 returned: %d", ret);
		}

		%orig(bulletin, arg2, arg3);
	} else {
		%orig(bulletin, arg2, arg3);
	}
}

%end

