#import <Foundation/Foundation.h>
#import "Notification.h"
#import <sqlite3.h>

@interface Db : NSObject 
+ (Db *)sharedInstance;
- (id)init;
- (bool)createDB;
- (int)addEntry:(Notification *)notification;
@end
