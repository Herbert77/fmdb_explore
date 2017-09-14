//
//  Person.m
//  FMDB的使用
//
//  Created by Herbert Hu on 2017/9/12.
//  Copyright © 2017年 Herbert Hu. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)mutableCopyWithZone:(NSZone *)zone {
    
    Person *ret = [[[self class] allocWithZone:zone] init];
//    ret.personId = self.personId;
    ret.name = self.name;
    ret.age = self.age;
    return ret;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
//        self.personId = [aDecoder decodeObjectForKey:@"personId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
//    [aCoder encodeObject:self.personId forKey:@"personId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.age forKey:@"age"];
}

- (NSString *)description {
    
    NSString *str = [NSString stringWithFormat:@"name: %@, age: %@", self.name, self.age];
    return str;
}

@end
