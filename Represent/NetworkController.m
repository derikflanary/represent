//
//  NetworkController.m
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import "NetworkController.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkController

+ (AFHTTPSessionManager *)api {
    
    static AFHTTPSessionManager *api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://whoismyrepresentative.com"]];
        api.responseSerializer = [AFJSONResponseSerializer serializer];
        api.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
    });
    return api;
}





@end
