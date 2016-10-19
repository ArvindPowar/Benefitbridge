//
//  MapViewController.h
//  BenefitBridge
//
//  Created by Infinitum on 03/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
@import MapKit;

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate,MKMapViewDelegate>
@property(nonatomic,retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,readwrite) CLLocationCoordinate2D currentLocation;
@property(nonatomic,retain) MKPointAnnotation *annotation;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSString *latiStr,*longStr,*pharmacynameStr;
@property (nonatomic, retain) MKPolyline *routeLine; //your line
@property (nonatomic, retain) MKPolylineView *routeLineView; //overlay view
@property(nonatomic, readwrite) double currentLong;
@property(nonatomic, readwrite) double curretnlatit;

@end
