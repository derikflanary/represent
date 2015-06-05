//
//  ViewController.m
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import "ViewController.h"
#import "CongressMemberController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CongressMemberController SharedInstance] repsByZip:@"31023" callback:^(NSMutableArray *repsArray) {
        
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
