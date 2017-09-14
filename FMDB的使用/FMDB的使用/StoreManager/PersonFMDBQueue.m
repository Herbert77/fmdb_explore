//
//  PersonFMDBQueue.m
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/13.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "PersonFMDBQueue.h"
#import <FMDatabaseAdditions.h>

@implementation PersonFMDBQueue

- (id)init {
    
    self = [super init];
    if (self != nil) {
        
        self.tableName = @"Person";
        [self createTable];
    }
    return self;
}

- (BOOL)createTable {
    
    __block BOOL result = YES;
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if (![db tableExists:self.tableName]) {
            
            NSString *sql = [NSString stringWithFormat:@"create table %@ (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL)", self.tableName];
            result = [db executeUpdate:sql];
        }
    }];
    
    return result;
}

- (BOOL)deleteTable {
    
    __block BOOL result = NO;
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sql = [NSString stringWithFormat:@"drop table %@", self.tableName];
        result = [db executeUpdate:sql];
    }];
    
    return result;
}

- (BOOL)addPersonItem:(Person *)personItem {
    
    __block BOOL result = NO;
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sql = [NSString stringWithFormat:@"insert into %@ values (:name, :age)", self.tableName];
        
        NSDictionary *params = @{@"name": @"Alice",
                                 @"age":@"20"};
        
        result = [db executeUpdate:sql withParameterDictionary:params];
    }];
    return result;
}

@end
