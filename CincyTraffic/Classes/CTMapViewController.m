//
//  CTMapViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/10/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCamerasViewController.h"
#import "CTMapViewController.h"
#import "CTCameraAnnotation.h"
#import "CTCameraSiteAnnotationView.h"
#import "CTCameraSite.h"

@interface CTMapViewController ()

@end

@implementation CTMapViewController
@synthesize mapView, cameras, mappedCameras;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINavigationController *navController = [self.tabBarController.viewControllers objectAtIndex:0];
    CTCamerasViewController *camerasController = [navController.viewControllers objectAtIndex:0];

    self.cameras = camerasController.cameras;
    self.mappedCameras = [NSMutableArray array];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;

    navController = nil;
    camerasController = nil;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setCameras:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.initialLocation = userLocation.location;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 6500, 6500);
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!self.initialLocation)
        return;

    NSMutableArray *newAnnotations = [NSMutableArray array];
    
    for (CTCameraSite *camera in self.cameras) {
        if (MKMapRectContainsPoint(self.mapView.visibleMapRect, MKMapPointForCoordinate(camera.coordinate))) {
            if (![self.mappedCameras containsObject:camera]) {
                CTCameraAnnotation* annotation = [[CTCameraAnnotation alloc] initWithCameraSite:camera];
                [newAnnotations addObject:annotation];
                [self.mappedCameras addObject:camera];
            }
        }
    }

    [self.mapView addAnnotations:newAnnotations];
    [self.annotations addObjectsFromArray:newAnnotations];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";

    if (annotation == mapView.userLocation)
        return nil;
    
    CTCameraSiteAnnotationView *annotationView = (CTCameraSiteAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil)
    {
        annotationView = [[CTCameraSiteAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:AnnotationViewID];
        annotationView.animatesDrop = YES;
    }

    annotationView.annotation = annotation;
    return annotationView;
}

@end
