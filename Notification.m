#import "Notification.h"

@implementation Notification
- (id)init {
	return [self initWithMessage: nil bulletinID:nil title:nil subtitle:nil section:nil];
}

- (id)initWithMessage:(NSString *)message bulletinID:(NSString *)bulletinID title:(NSString *)title subtitle:(NSString *)subtitle section:(NSString *)section {
	self = [super init];
	if(self) {
		_message = message;
		_bulletinID = bulletinID;
		_title = title;
		_subtitle = subtitle;
		_section = section;
	}
	return self;
}
@end
