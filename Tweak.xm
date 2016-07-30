/*
 * NotiLog
 *
 * Written by Gianguido (gsora) Sorà
 * Twitter: @gsora_
 *
 * MIT License.
 */

static NSString *TWEAK_SETTINGS_PATH = @"/User/Library/Preferences/xyz.gsora.notilog.plist";
#define SAVED_STRING (CFStringRef)@"xyz.gsora.notilog.saved"

/*
 * Interfaces to hook in
 */
@interface BBBulletin
- (NSString *)description;
- (NSString *)message;
- (NSString *)title;
- (NSString *)subtitle;
- (id)init;
+ (instancetype)alloc;
- (void)setMessage:(NSString *)newMessage;
@end

@interface BBServer
-(void)publishBulletin:(BBBulletin *)bulletin destinations:(unsigned int)arg2 alwaysToLockScreen:(BOOL)arg3;
@end


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
	HBLogDebug(@"Value of 'enabled': %d", enabled);
	if(enabled) {
       		HBLogDebug(@"New notification incoming!");
		HBLogDebug(@"Message: %@", [bulletin message]);
		%orig(bulletin, arg2, arg3);
	} else {
		%orig(bulletin, arg2, arg3);
	}
}

%end

