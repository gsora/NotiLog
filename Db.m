#import "Db.h"

static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
static Db *sharedInstance = nil;
static NSString *path = @"/User/Library/notilog.db";

@implementation Db

- (id)init {
	self = [super init];
	if(self){}
	return self;
}

+ (Db *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Db alloc] init];
    });
    return sharedInstance;	  
}

- (bool)createDB {
	bool success = true;
	NSFileManager *fmanager = [NSFileManager defaultManager];    
	if(![fmanager fileExistsAtPath:path]) {
		const char *dbPath = [path UTF8String];
		if(sqlite3_open(dbPath, &database) != SQLITE_OK) {
			NSLog(@"Failed to create database.");
			success = false;
			return success;
		}
		char *errMsg;
		char *statement = "create table if not exists notilog (date text, message text, bulletinID text, title text, subtitle text, section text)";

		if(sqlite3_exec(database, statement, NULL, NULL, &errMsg) != SQLITE_OK) {
			success = false;
			NSLog(@"%s", errMsg);
		}
		sqlite3_close(database);
	}
	return success;
}

- (int)addEntry:(Notification *)notification {
	const char *dbPath = [path UTF8String];
	if(sqlite3_open(dbPath, &database) != SQLITE_OK) {
		NSLog(@"Failed to open database.");
		return 999;
	}

	NSString *query = [NSString stringWithFormat:@"insert into notilog (date, message, bulletinID, title, subtitle, section) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", [notification date], [notification message], [notification bulletinID], [notification title], [notification subtitle], [notification section]];

	sqlite3_prepare_v2(database, [query UTF8String],-1, &statement, NULL);
	int sql_status = sqlite3_step(statement);
	sqlite3_reset(statement);
	return sql_status;
}

@end
