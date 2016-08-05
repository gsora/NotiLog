#import <Foundation/Foundation.h>

@interface Notification : NSObject {}

@property (nonatomic,retain) NSString *message;
@property (nonatomic,retain) NSString *bulletinID;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *section;

- (id)init;
- (id)initWithMessage:(NSString *)message bulletinID:(NSString *)bulletinID title:(NSString *)title subtitle:(NSString *)subtitle section:(NSString *)section; 

@end

