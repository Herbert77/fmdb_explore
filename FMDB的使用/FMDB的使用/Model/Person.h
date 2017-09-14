//
//  Person.h
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSMutableCopying, NSCoding>

//@property (strong, nonatomic) NSString *personId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;

@end
