//
//  CTMapViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/10/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CameraSite.h"
#import "CTCameraViewController.h"
#import "CTMapViewController.h"
#import "CTCameraAnnotation.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadCameras)
                                                 name:@"camerasReloaded"
                                               object:nil];

    self.initialLocation = nil;
    [self loadCameras];
    
    self.mappedCameras = [NSMutableArray array];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;

}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setCameras:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (self.initialLocation != nil) return;
    self.initialLocation = userLocation.location;
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 6500, 6500) animated:YES];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    ADClusterAnnotation *annotation = (ADClusterAnnotation *)view.annotation;
    CTCameraAnnotation *point = [[[annotation originalAnnotations] objectAtIndex:0] annotation];
    CameraSite *cameraSite = point.cameraSite;

    [TestFlight passCheckpoint:cameraSite.description];

    [self performSegueWithIdentifier:@"mapCameraDetail" sender:cameraSite];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"mapCameraDetail"]) {
        [[segue destinationViewController] setCamera:sender];
    }
}

- (void)loadCameras
{
    self.cameras = [NSMutableArray arrayWithArray:[CameraSite allCameras]];

    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (CameraSite *camera in self.cameras) {
            CTCameraAnnotation *annotation = [[CTCameraAnnotation alloc] initWithCameraSite:camera];
            [annotations addObject:annotation];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView setAnnotations:annotations];
        });
    });
}

#pragma mark - ADClusterMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pinView = (MKAnnotationView *)[theMapView dequeueReusableAnnotationViewWithIdentifier:@"ADClusterableAnnotation"];
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                reuseIdentifier:@"ADClusterableAnnotation"];
        pinView.image = [UIImage imageNamed:@"SingleCamera.png"];
        pinView.canShowCallout = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = button;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}

- (MKAnnotationView *)mapView:(ADClusterMapView *)theMapView viewForClusterAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView * pinView = (MKAnnotationView *)[theMapView dequeueReusableAnnotationViewWithIdentifier:@"ADMapCluster"];
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ADMapCluster"];
        pinView.image = [UIImage imageNamed:@"Group+.png"];
        pinView.canShowCallout = YES;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}

- (NSString *)clusterTitleForMapView:(ADClusterMapView *)mapView
{
    return @"%d cameras";
}

- (NSInteger)numberOfClustersInMapView:(ADClusterMapView *)mapView {
    return 16;
}

- (double)clusterDiscriminationPowerForMapView:(ADClusterMapView *)mapView {
    return 2.5;
}

@end
