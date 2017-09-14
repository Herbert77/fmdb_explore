//
//  BaseFMDBQueue.h
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>

@interface BaseFMDBQueue : NSObject

@property (retain, nonatomic) FMDatabaseQueue *queue;
@property (copy, nonatomic) NSString *tableName;
@property (copy, nonatomic) NSString *dbPath;

@end
