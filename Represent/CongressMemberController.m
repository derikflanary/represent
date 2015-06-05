//
//  CongressMemberController.m
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import "CongressMemberController.h"
#import "NetworkController.h"
#import "CongressMember.h"

@implementation CongressMemberController

+ (CongressMemberController *)SharedInstance {
    static CongressMemberController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CongressMemberController new];
    });
    return sharedInstance;
}

#pragma mark - Reps By Zipcode

- (NSString*)pathForRepByZip:(NSString *)zip{
    
    return[NSString stringWithFormat:@"/getall_mems.php?zip=%@&output=json", zip];
}

- (void)repsByZip:(NSString *)zip callback:(void (^)(NSMutableArray *repsArray))callback{
    //get url
    NSString *pathURL = [[CongressMemberController SharedInstance] pathForRepByZip:zip];
    //api call
    [[NetworkController api]GET:pathURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //collect data into array
        NSDictionary *responseDictionary = responseObject;
        NSArray *repsArray = responseDictionary[@"results"];
        NSMutableArray *congressMembersArray = [NSMutableArray array];
        for (NSDictionary *dictionary in repsArray) {
            CongressMember *congressMember = [[CongressMember alloc]initWithDictionary:dictionary];
            [congressMembersArray addObject:congressMember];
        }
        callback(congressMembersArray);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        callback(nil);
    }];
}

@end
