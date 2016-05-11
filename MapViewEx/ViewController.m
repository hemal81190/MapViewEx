//
//  ViewController.m
//  MapViewEx
//
//  Created by Yosemite on 5/9/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize map_vw,txt_search;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    
    
}
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[map_vw dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    annotationView.image = [UIImage imageNamed:@"Street View-20.png"];
    annotationView.annotation = annotation;
    
    return annotationView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_search:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *addr=txt_search.text;
    
    NSString *st_format=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//kalawad%20road%20rajkot
    
    NSURL *url=[NSURL URLWithString:st_format];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"lat:%@",[[[[[dict objectForKey:@"results"]objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lat"]);
    NSLog(@"lng:%@",[[[[[dict objectForKey:@"results"]objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lng"]);
    
    map_vw.delegate=self;
    
    CLLocationCoordinate2D loc;
    loc.latitude=[[[[[[dict objectForKey:@"results"]objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lat"]floatValue];
    loc.longitude=[[[[[[dict objectForKey:@"results"]objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lng"]floatValue];
    
    
    MKCoordinateRegion regin;
    regin.center=loc;
    regin.span.latitudeDelta=0.01;
    regin.span.longitudeDelta=0.01;
    
    
    MKPointAnnotation *point=[[MKPointAnnotation alloc]init];
    point.coordinate=loc;
    
    [map_vw addAnnotation:point];
    [map_vw setRegion:regin];
    [map_vw regionThatFits:regin];
}
@end
