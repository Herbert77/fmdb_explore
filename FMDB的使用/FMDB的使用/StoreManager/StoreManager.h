//
//  StoreManager.h
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonStoreProtocol.h"

@interface StoreManager : NSObject

+ (id<PersonStoreProtocol>)personStoreProtocol;

@end
