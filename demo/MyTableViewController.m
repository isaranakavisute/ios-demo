//
//  MyTableViewController.m
//  demo
//
//  Created by KitBadbloos on 24/11/2562 BE.
//  Copyright © 2562 KitBadbloos. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = 110;
    
    NSString *city_url = nil;
    
    
    //retrieve value from db
    NSString *db_url = nil;
    db_url = [NSString stringWithFormat:@"%@",@"http://thexxyyzz.xyz/isara/ios_retrieve.php"];
    NSURLRequest* requestForDBRetrieve = [NSURLRequest requestWithURL:[NSURL URLWithString:db_url]];
    NSURLResponse* db_response = nil;
    NSError* db_error = nil; //do it always
    NSData* db_returndata = [NSURLConnection sendSynchronousRequest:requestForDBRetrieve returningResponse:&db_response error:&db_error];
    
    NSString *city_name = [[NSString alloc] initWithData:db_returndata encoding:NSUTF8StringEncoding];
    
    city_url = [NSString stringWithFormat:@"%@%@%@",@"http://api.openweathermap.org/data/2.5/forecast?q=",city_name,@"&APPID=164e7199b80c3e225bf99b5e71d7913c&cnt=7"];
    
     NSURLRequest* requestForWeatherData = [NSURLRequest requestWithURL:[NSURL URLWithString:city_url]];
        
     NSURLResponse* response = nil;
     NSError* error = nil; //do it always
    
     NSData* data = [NSURLConnection sendSynchronousRequest:requestForWeatherData returningResponse:&response error:&error]; //for saving all of received data in non-serialized view
       
     allData = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]; //data in serialized view
    
     
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (nil==cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mycell"];
    }
    
    //temp = [allData[@"main"][@"temp"] intValue]-273.15;
    //humidity = [allData[@"main"][@"humidity"] intValue];
    //temp_label.text = [NSString stringWithFormat:@"%@%d%@", @"Temperature=",temp,@"(C)"];
    //humidity_label.text = [NSString //stringWithFormat:@"%@%d%@",@"Humidity=",humidity,@"%"];
    
    
    //cell.imageView.image
    //cell.textLabel.text =
    
    
    
    
    float temp_min = [allData[@"list"][indexPath.row][@"main"][@"temp_min"] floatValue]-273.15;
    float temp_max = [allData[@"list"][indexPath.row][@"main"][@"temp_max"] floatValue]-273.15;
    cell.textLabel.text = [NSString stringWithFormat:@" %@:%.2f%@/%.2f%@",allData[@"list"][indexPath.row][@"weather"][0][@"main"],temp_min,@"(C)",temp_max,@"(C)"];
        
    
    //allData[@"list"][indexPath.row][@"weather"][@"icon"];
    
    
    NSString* image_url = [NSString stringWithFormat:@"%@/%@%@", @"http://openweathermap.org/img/wn", allData[@"list"][indexPath.row][@"weather"][0][@"icon"], @"@2x.png"];
       
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];
       
    //[current_weather_image.layer setBorderColor: [[UIColor blackColor] CGColor]];
    //[current_weather_image.layer setBorderWidth: 2.0];
    //current_weather_image.image=image;
   
    [cell.imageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [cell.imageView.layer setBorderWidth: 2.0];
    cell.imageView.image = image;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
