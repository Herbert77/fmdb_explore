//
//  StoreManager.m
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "StoreManager.h"
#import "PersonFMDBQueue.h"

static id<PersonStoreProtocol> personStoreProtocol = nil;

@implementation StoreManager

+ (id<PersonStoreProtocol>)personStoreProtocol {
    
    @synchronized (self) {
        if (personStoreProtocol == nil) {
            
            personStoreProtocol = [[PersonFMDBQueue alloc] init];
        }
    }
    return personStoreProtocol;
}

@end
