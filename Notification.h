#import <Foundation/Foundation.h>

@interface Notification : NSObject <NSCoding> {}

@property (nonatomic,retain) NSString *message;
@property (nonatomic,retain) NSString *bulletinID;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subtitle;
@property (nonatomic,retain) NSString *section;
@property (nonatomic, retain) NSString *date;

- (id)init;
- (id)initWithMessage:(NSString *)message bulletinID:(NSString *)bulletinID title:(NSString *)title subtitle:(NSString *)subtitle section:(NSString *)section date:(NSString *)date; 
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)encoder;
@end

