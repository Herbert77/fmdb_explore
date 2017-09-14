//
//  PersonFMDBQueue.h
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/13.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "BaseFMDBQueue.h"
#import "PersonStoreProtocol.h"

@interface PersonFMDBQueue : BaseFMDBQueue <PersonStoreProtocol>

@end
