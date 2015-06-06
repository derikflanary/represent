//
//  ViewController.m
//  Represent
//
//  Created by Derik Flanary on 6/5/15.
//  Copyright (c) 2015 Derik Flanary. All rights reserved.
//

#import "DetailViewController.h"
#import "CongressMemberController.h"
#import <CoreLocation/CoreLocation.h>
#import "CongressMember.h"

//#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *link;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [self currentLocationIdentifier];
    
}

- (void)currentLocationIdentifier{
    //---- For getting current gps location
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = [locations objectAtIndex:0];
    [manager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             self.zipcode = placemark.postalCode;
             self.title = self.zipcode;
             [[CongressMemberController SharedInstance] repsByZip:self.zipcode callback:^(NSMutableArray *repsArray) {
                 self.dataArray = repsArray;
                 [self.tableView reloadData];
             }];
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error); // Error handling must required
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Name";
    }else if (section == 1){
        return @"Party";
    }else if (section == 2){
        return @"State";
    }else if (section == 3){
        return @"District";
    }else if (section == 4){
        return @"Phone";
    }else if (section == 5){
        return @"Office Address";
    }else if (section == 6){
        return @"Link";
    }else{
        return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell){
        cell = [UITableViewCell new];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CongressMember *congressMember = [self.dataArray objectAtIndex:0];
    if (indexPath.section == 0) {
        cell.textLabel.text = congressMember.name;
    }else if (indexPath.section == 1){
        cell.textLabel.text = congressMember.party;
    }else if (indexPath.section == 2){
        cell.textLabel.text = congressMember.state;
    }else if (indexPath.section == 3){
        cell.textLabel.text = congressMember.district;
    }else if (indexPath.section == 4){
        cell.textLabel.text = congressMember.phone;
    }else if (indexPath.section == 5){
        cell.textLabel.text = congressMember.officeAddress;
    }else{
        cell.textLabel.text = congressMember.link;
        self.link = congressMember.link;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 6) {
        NSURL *url = [NSURL URLWithString:self.link];
        
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
        }
    }
}


@end
