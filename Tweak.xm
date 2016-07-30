/*
 * NotiLog
 *
 * Written by Gianguido (gsora) Sorà
 * Twitter: @gsora_
 *
 * MIT License.
 */

#define TWEAK_NAME xyz.gsora.notilog
#define TWEAK_SETTIGNS_PATH /User/Library/Preferences/xyz.gsora.notilog_prefs.plist

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

%hook BBServer

-(void)publishBulletin:(BBBulletin *)bulletin destinations:(unsigned int)arg2 alwaysToLockScreen:(BOOL)arg3 {

  	NSMutableDictionary *settingsDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"TWEAK_SETTINGS_PATH"];
	if([settingsDict[@"Enabled"] boolValue]) {
       		HBLogDebug(@"New notification incoming!");
		HBLogDebug(@"Message: %@", [bulletin message]);
		%orig(bulletin, arg2, arg3);
	} else {
		%orig(bulletin, arg2, arg3);
	}
}

%end

