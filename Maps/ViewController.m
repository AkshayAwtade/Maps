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
    [location startUpdatingLocation];
//    [location sta]
//    self.map.showsUserLocation=YES;
    UILongPressGestureRecognizer *longPressRecognizer =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handeLongPress:)];
    longPressRecognizer.minimumPressDuration=1.0;
    [self.map addGestureRecognizer:longPressRecognizer];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)handeLongPress: (UIGestureRecognizer *)gesture{
    if(gesture.state==UIGestureRecognizerStateBegan)
    {
        CGPoint point =[gesture locationInView:gesture.view];
        CLLocationCoordinate2D coordinates =[self.map convertPoint:point toCoordinateFromView:gesture.view];
    MKPointAnnotation *mapAnnotion =[[MKPointAnnotation alloc]init];
    [self.map addAnnotation:mapAnnotion];
    
        CLGeocoder *geocoder=[[CLGeocoder alloc]init];
        CLLocation *annotationCoordinates =[[CLLocation alloc]initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
        [geocoder reverseGeocodeLocation:annotationCoordinates completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error != nil)
            {
                NSLog(@"%@",error.localizedDescription);
                return ;
            }
            if(placemarks.count>0)
            {
                CLPlacemark *placeMark =placemarks.firstObject;
                
                NSString *title;
                if(placeMark.thoroughfare !=nil)
                {
                    if(placeMark.subThoroughfare !=nil)
                    {
                        title =[placeMark.thoroughfare stringByAppendingString:placeMark.subThoroughfare];
                    }
                    else{
                        title = placeMark.thoroughfare;
                    }
                }
                NSString *subtitle =placeMark.locality;
                mapAnnotion.title =title;
                ;
                mapAnnotion.subtitle=subtitle;
            }
            else
            {
                mapAnnotion.title=@"Unknown place";
                
            }
            [self.map addAnnotation:mapAnnotion];
        }];
    }
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


-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D locationUpdate=userLocation.coordinate;
    MKCoordinateSpan span =MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region =MKCoordinateRegionMake(locationUpdate, span);
    [mapView setRegion:region animated:YES];
}
@end
