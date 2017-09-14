//
//  FMDBQueueManager.h
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>

@interface FMDBQueueManager : NSObject

@property (readonly, nonatomic) FMDatabaseQueue *queue;
@property (readonly, nonatomic) NSString *dbPath;

+ (FMDBQueueManager *)sharedFMDBQueueManager;

@end
