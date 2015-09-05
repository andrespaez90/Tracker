//
//  ViewController.m
//  Tracker
//
//  Created by INNOVATING SOFTWARE SAS on 29/08/15.
//  Copyright (c) 2015 INNOVATING SOFTWARE SAS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray *annotations;
    Boolean *savePlace;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.Map.delegate = self;
    [self.Map setShowsUserLocation:YES];
    
    savePlace = true;
    annotations = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

@synthesize locationManager;
@synthesize optionStartStop;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.locationManager = [[CLLocationManager alloc] init];
    geoCorder = [[CLGeocoder alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    return YES;
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didLocationFail",error);
}

-(void)locationManager:(CLLocationManager *)manager didupdate:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocation *currentLocation = newLocation;
    
    [geoCorder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if( error != nil && [placemarks count] != 0) {
            placeMark = [placemarks lastObject];
        }
    }];
    
}

-(IBAction)optionStartStop{
    if( savePlace ){
        savePlace = false;
        [optionStartStop setTitle:@"Start" forState:UIControlStateNormal];
    }
    else{
        savePlace = true;
        [optionStartStop setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

-(IBAction)optionRestar{
    for(NSInteger i =0; i < [annotations count] -1;i++){
        [self.Map removeAnnotation:[annotations objectAtIndex:i ]];
    }
}

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D myLocation = [userLocation coordinate];
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 2500, 2500);
    
    if(savePlace){
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:myLocation];
        [annotations addObject:annotation];
        [self.Map addAnnotation:annotation];
    }
    
    [self.Map setRegion:zoomRegion animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
