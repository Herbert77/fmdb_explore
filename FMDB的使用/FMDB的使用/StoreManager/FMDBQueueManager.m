//
//  FMDBQueueManager.m
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "FMDBQueueManager.h"
#import "Person.h"

@interface FMDBQueueManager ()

@property (strong, nonatomic) FMDatabaseQueue *queue;
@property (strong, nonatomic) NSString *dbPath;

@end

@implementation FMDBQueueManager

+ (FMDBQueueManager *)sharedFMDBQueueManager {
    
    static FMDBQueueManager *sharedManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        sharedManger = [[FMDBQueueManager alloc] init];
    });
    return sharedManger;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    
//    [self closeDB];
}

- (NSString *)dbPath {
    
    if (!_dbPath) {
        
        NSArray *fileArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *doc = [fileArray lastObject];
        NSString *dbFileName = [doc stringByAppendingString:@"student.sqlite"];
        NSLog(@"dbFileName %@", dbFileName);
        
        _dbPath = dbFileName;
    }
    return _dbPath;
}

- (FMDatabaseQueue *)queue {
    
    if (!_queue) {
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _queue;
}

- (void)colseDB {
    
    if (_queue != nil) {
        
        [_queue close];
    }
    _queue = nil;
}

- (BOOL)getStudentsItemWithNameLike:(NSString *)nameLike toArray:(NSMutableArray *)array {
    
    __block BOOL result = NO;
    if (array == nil) {
        return result;
    }
    
    NSString *tableName = @"Student";
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sql = [NSString stringWithFormat:@"select distinct personId, name, age from %@", tableName];
        
        FMResultSet *resultSet = [db executeQuery:sql];
        
        while ([resultSet next]) {
            
            result = YES;
            
            Person *person = [Person new];
            
//            person.personId = [resultSet stringForColumn:@"personId"];
            person.name = [resultSet stringForColumn:@"name"];
            person.age = [resultSet stringForColumn:@"age"];
            
            [array addObject:person];
        }
        
        [resultSet close];
    }];
    return result;
}

@end
