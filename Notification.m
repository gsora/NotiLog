#import "Notification.h"

@implementation Notification

- (id)init {
	return [self initWithMessage: nil bulletinID:nil title:nil subtitle:nil section:nil date:nil];
}

- (id)initWithMessage:(NSString *)message bulletinID:(NSString *)bulletinID title:(NSString *)title subtitle:(NSString *)subtitle section:(NSString *)section date:(NSString *)date {
	self = [super init];
	if(self) {
		_message = message;
		_bulletinID = bulletinID;
		_title = title;
		_subtitle = subtitle;
		_section = section;
		_date = date;
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:_message forKey:@"message"];
  [encoder encodeObject:_bulletinID forKey:@"bulletinID"];
  [encoder encodeObject:_title forKey:@"title"];
  [encoder encodeObject:_subtitle forKey:@"subtitle"];
  [encoder encodeObject:_section forKey:@"section"];
  [encoder encodeObject:_date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	NSString *message = [aDecoder decodeObjectForKey:@"message"];
	NSString *bulletinID = [aDecoder decodeObjectForKey:@"bulletinID"];
	NSString *title = [aDecoder decodeObjectForKey:@"title"];
	NSString *subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
	NSString *section = [aDecoder decodeObjectForKey:@"section"];
	NSString *date = [aDecoder decodeObjectForKey:@"date"];
	return [self initWithMessage:message bulletinID:bulletinID title:title subtitle:subtitle section:section date:date];
}



@end
