//
//  CongressMemberController.h
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CongressMemberController : NSObject

+ (CongressMemberController *)SharedInstance;
- (void)repsByZip:(NSString *)zip callback:(void (^)(NSMutableArray *repsArray))callback;

@end
