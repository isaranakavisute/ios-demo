//
//  ViewController.m
//  demo
//
//  Created by KitBadbloos on 23/11/2562 BE.
//  Copyright © 2562 KitBadbloos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize current_weather_image;
@synthesize temp_label;
@synthesize humidity_label;
@synthesize city_name_tf;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [current_weather_image.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [current_weather_image.layer setBorderWidth: 2.0];
    temp_unit = @"C";
    [_c_f_btn.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_c_f_btn.layer setBorderWidth: 2.0];
    
}

- (IBAction)on_c_f:(id)sender
{
 NSString *city_url = nil;
 city_url = [NSString stringWithFormat:@"%@%@%@",@"http://api.openweathermap.org/data/2.5/weather?q=",city_name_tf.text,@"&APPID=164e7199b80c3e225bf99b5e71d7913c"];
    
 NSURLRequest* requestForWeatherData = [NSURLRequest requestWithURL:[NSURL URLWithString:city_url]];
    
NSURLResponse* response = nil;
NSError* error = nil; //do it always
    
NSData* data = [NSURLConnection sendSynchronousRequest:requestForWeatherData returningResponse:&response error:&error]; //for saving all of received data in non-serialized view
       
NSMutableDictionary *allData = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]; //data in serialized view
    
 if ([temp_unit isEqualToString:@"C"])
 {
  temp_unit = @"F";
  int temp = [allData[@"main"][@"temp"] intValue]-273;
  float new_temp = (((temp*1.0)/5.0)*9.0)+32;
  temp_label.text = [NSString stringWithFormat:@"%@%.2f%@", @"Temperature=",new_temp,@"(F)"];
 }
 else
 {
  temp_unit = @"C";
  int temp = [allData[@"main"][@"temp"] intValue]-273;
  temp_label.text = [NSString stringWithFormat:@"%@%d%@", @"Temperature=",temp,@"(C)"];
 }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    global_city_name = city_name_tf.text;
    
    

    NSString *db_url = nil;
    db_url = [NSString stringWithFormat:@"%@%@",@"http://thexxyyzz.xyz/isara/ios.php?s=",city_name_tf.text];
    NSURLRequest* requestForDBSave = [NSURLRequest requestWithURL:[NSURL URLWithString:db_url]];
    NSURLResponse* db_response = nil;
    NSError* db_error = nil; //do it always
    NSData* db_returndata = [NSURLConnection sendSynchronousRequest:requestForDBSave returningResponse:&db_response error:&db_error];
    
    

    NSString *city_url = nil;
    city_url = [NSString stringWithFormat:@"%@%@%@",@"http://api.openweathermap.org/data/2.5/weather?q=",city_name_tf.text,@"&APPID=164e7199b80c3e225bf99b5e71d7913c"];
    
     NSURLRequest* requestForWeatherData = [NSURLRequest requestWithURL:[NSURL URLWithString:city_url]];
    
    //http://api.openweathermap.org/data/2.5/forecast?q=bangkok,thailand&APPID=164e7199b80c3e225bf99b5e71d7913c&cnt=7
    
       NSURLResponse* response = nil;
       NSError* error = nil; //do it always
    
       NSData* data = [NSURLConnection sendSynchronousRequest:requestForWeatherData returningResponse:&response error:&error]; //for saving all of received data in non-serialized view
       
       NSMutableDictionary *allData = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]; //data in serialized view
    
    
       NSString* currentWeather = nil;
       NSString* icon = nil;
       NSString* image_url = nil;
       int temp = 0;
       int humidity = 0;
       NSString* key = nil;
       NSString* value = nil;
       NSDictionary* mymain=nil;
       
       NSArray* main = allData[@"main"];
       NSArray* weather = allData[@"weather"];
    
       
       //for (NSDictionary* weatherDictionary in main)
       //{
        //mymain= weatherDictionary[@"main"];
        //temp = main[3][0];
        //humidity = main[0][0];
       //}
    
       temp = [allData[@"main"][@"temp"] intValue]-273.15;
       humidity = [allData[@"main"][@"humidity"] intValue];
       temp_label.text = [NSString stringWithFormat:@"%@%d%@", @"Temperature=",temp,@"(C)"];
       humidity_label.text = [NSString stringWithFormat:@"%@%d%@",@"Humidity=",humidity,@"%"];
    
       
       
       
       for (NSDictionary* weatherDictionary in weather)
       {
           currentWeather = weatherDictionary[@"main"];
           icon = weatherDictionary[@"icon"];
       }
    
     temp = [allData[@"main"][@"temp"] intValue]-273.15;
     humidity = [allData[@"main"][@"humidity"] intValue];
     temp_label.text = [NSString stringWithFormat:@"%@:%@%d%@",currentWeather, @"Temperature=",temp,@"(C)"];
     humidity_label.text = [NSString stringWithFormat:@"%@%d%@",@"Humidity=",humidity,@"%"];
    
    
      image_url = [NSString stringWithFormat:@"%@/%@%@", @"http://openweathermap.org/img/wn", icon, @"@2x.png"];
    
      UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];
    
      [current_weather_image.layer setBorderColor: [[UIColor blackColor] CGColor]];
      [current_weather_image.layer setBorderWidth: 2.0];
      current_weather_image.image=image;
    
      
      
    
    
    /*
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                               message:@"This is an alert."
                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    */
    
    return NO;
}



@end
