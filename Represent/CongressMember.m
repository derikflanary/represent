//
//  CongressMember.m
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import "CongressMember.h"

static NSString * const nameKey = @"name";
static NSString * const partyKey = @"party";
static NSString * const stateKey = @"state";
static NSString * const districtKey = @"district";
static NSString * const phoneKey = @"phone";
static NSString * const officeAddressKey = @"office";
static NSString * const linkKey = @"link";

@implementation CongressMember

- (id)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [super init];
    if (self) {
        self.name = dictionary[nameKey];
        self.party = dictionary[partyKey];
        self.state = dictionary[stateKey];
        self.district = dictionary[districtKey];
        self.phone = dictionary[phoneKey];
        self.officeAddress = dictionary[officeAddressKey];
        self.link = dictionary[linkKey];
    }
    
    return self;
}


@end
