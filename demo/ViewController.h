//
//  ViewController.h
//  demo
//
//  Created by KitBadbloos on 23/11/2562 BE.
//  Copyright © 2562 KitBadbloos. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString* temp_unit;
NSString* global_city_name;

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *ios_demo_label;

@property (strong, nonatomic) IBOutlet UILabel *city_name_label;

@property (weak, nonatomic) IBOutlet UITextField *city_name_tf;

@property (weak, nonatomic) IBOutlet UILabel *temp_label;

@property (weak, nonatomic) IBOutlet UILabel *humidity_label;



@property (weak, nonatomic) IBOutlet UIImageView *current_weather_image;


@property (strong, nonatomic) IBOutlet UIView *c_f_btn;

@property (strong, nonatomic) IBOutlet UIView *topage2;


@end

