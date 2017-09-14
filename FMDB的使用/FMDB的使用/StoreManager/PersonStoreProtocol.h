//
//  PersonStoreProtocol.h
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/13.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@protocol PersonStoreProtocol <NSObject>

- (BOOL)addPersonItem:(Person *)personItem;

@end
