//
//  BaseFMDBQueue.m
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "BaseFMDBQueue.h"
#import "FMDBQueueManager.h"

@implementation BaseFMDBQueue

- (NSString *)dbPath {
    
    return [[FMDBQueueManager sharedFMDBQueueManager] dbPath];
}

- (id)queue {
    
    return [[FMDBQueueManager sharedFMDBQueueManager] queue];
}

#pragma mark - BaseStore
- (BOOL)createStore {
    
    NSLog(@"success to create db store");
    return NO;
}

- (BOOL)clearStore {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sql = [NSString stringWithFormat:@"delete from %@", self.tableName];
        BOOL result = [db executeUpdate:sql];
        if (!result) {
            
            NSLog(@"Failed to clear db data.");
        }
        else {
            
            NSLog(@"Success to clear db data.");
        }
    }];
    
    return YES;
}

- (BOOL)deleteStore {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sql = [NSString stringWithFormat:@"drop table %@", self.tableName];
        BOOL result = [db executeUpdate:sql];
        if (!result) {

            NSLog(@"Failed to delete table %@.", self.tableName);
        }
        else {
            
            NSLog(@"Success to delete table %@.", self.tableName);
        }
    }];
    return YES;
}

- (BOOL)recreateStore {
    
    [self deleteStore];
    BOOL result = [self createStore];
    return result;
}

@end
