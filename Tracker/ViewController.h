//
//  ViewController.h
//  Tracker
//
//  Created by INNOVATING SOFTWARE SAS on 29/08/15.
//  Copyright (c) 2015 INNOVATING SOFTWARE SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLGeocoder *geoCorder;
    CLPlacemark *placeMark;
}

@property (weak, nonatomic) IBOutlet MKMapView *Map;
@property (weak, nonatomic) IBOutlet UIButton *optionStartStop;
@property (weak, nonatomic) IBOutlet UIButton *Reset;


@property (strong,nonatomic)CLLocationManager *locationManager;

@end

