//
//  ViewController.m
//  Maps
//
//  Created by Student P_03 on 06/09/16.
//  Copyright © 2016 AkshayAwtade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    location=[[CLLocationManager alloc]init];
    [location setDesiredAccuracy:kCLLocationAccuracyBest];
    [location requestWhenInUseAuthorization];
    self.map.showsUserLocation=YES;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    presentLocation =locations.lastObject;
        presentLocation=[[CLLocation alloc]initWithLatitude:presentLocation.coordinate.latitude longitude:presentLocation.coordinate.longitude];
    NSLog(@"%f,%f",presentLocation.coordinate.latitude,presentLocation.coordinate.latitude);
    
    
   
}



- (IBAction)segmentControllerMapValueChanged:(id)sender {
    UISegmentedControl *segment =sender;
    if(segment.selectedSegmentIndex==0)
    {
        [self.map setMapType:MKMapTypeStandard];
    }
else
    if(segment.selectedSegmentIndex==1)
    {
        [self.map setMapType:MKMapTypeSatellite];
    }
    else
        if(segment.selectedSegmentIndex==2)
        {
            [self.map setMapType:MKMapTypeHybrid];
        }

        
        }
@end
