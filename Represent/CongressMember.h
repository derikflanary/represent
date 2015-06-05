//
//  CongressMember.h
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CongressMember : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *party;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *officeAddress;
@property (nonatomic, strong) NSString *link;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
