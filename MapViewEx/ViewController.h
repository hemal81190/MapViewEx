//
//  ViewController.h
//  MapViewEx
//
//  Created by Yosemite on 5/9/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map_vw;
@property (weak, nonatomic) IBOutlet UITextField *txt_search;
- (IBAction)btn_search:(id)sender;


@end

