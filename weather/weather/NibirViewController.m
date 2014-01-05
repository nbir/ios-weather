//
//  NibirViewController.m
//  weather
//
//  Created by Nibir Bora on 12/4/13.
//  Copyright (c) 2013 Nibir Bora. All rights reserved.
//

#import "NibirViewController.h"
#import <Social/Social.h>

@interface NibirViewController ()

@end




NSString *location;
NSString *loc_type;
NSString *unit = @"f";
BOOL valid_loc = false;
NSString *image_url;
NSString *weather_link;
NSMutableDictionary *json;




@implementation NibirViewController




-(IBAction)hide_keyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}




-(IBAction)unit_selector:(id)sender {
    if (unit_type.selectedSegmentIndex == 1) {
        unit = @"c";
    }
    else {
        unit = @"f";
    }
}




-(IBAction)search_button:(id)sender {
    location = @"";
    valid_loc = false;
    
    location = location_input.text;
    location = [location stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]];
    
    if ([location length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"Please enter a location."
                              delegate:nil
                              cancelButtonTitle:@"Done"
                              otherButtonTitles:nil,
                              nil];
        [alert show];
    }
    else {
        BOOL numeric;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:location];
        numeric = [alphaNums isSupersetOfSet:inStringSet];

        if (numeric) {
            if ([location length] != 5) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Error"
                                      message:@"Invalid ZIP code."
                                      delegate:nil
                                      cancelButtonTitle:@"Done"
                                      otherButtonTitles:nil,
                                      nil];
                [alert show];
            }
            else {
                valid_loc = true;
                loc_type = @"zip";
            }
        }
        else {
            if ([location rangeOfString:@","].location == NSNotFound) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"Error"
                                      message:@"Location should contain state or country."
                                      delegate:nil
                                      cancelButtonTitle:@"Done"
                                      otherButtonTitles:nil,
                                      nil];
                [alert show];

            } else {
                valid_loc = true;
                loc_type = @"city";
            }
        }
    }
    
    if (valid_loc) {
        NSString *base_url = @"http://nibir.me/get_weather.php";
        
        NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                         base_url,
                         @"?location=",
                         [location
                          stringByReplacingOccurrencesOfString:
                          @" " withString:@"%20"],
                         @"&loc_type=",
                         loc_type,
                         @"&unit=",
                         unit];

        
        NSData *json_data = [[NSData alloc] initWithContentsOfURL:
                            [NSURL URLWithString:url]];
        
        NSError *error;
        json = [NSJSONSerialization
                JSONObjectWithData:json_data
                options:NSJSONReadingMutableContainers
                error:&error];
        
        
        if (json[@"location"]) {
            
            location_city.text = json[@"location"][@"city"];
            location_region.text = [NSString stringWithFormat:@"%@%@%@",
                                    json[@"location"][@"region"],
                                    @", ",
                                    json[@"location"][@"country"]];
            weather_condition.text = json[@"condition"][@"text"];
            weather_temp.text = [[NSString stringWithFormat:@"%@%@%@",
                                  json[@"condition"][@"temp"],
                                  @"\u00B0",
                                  unit]
                                 uppercaseString];
            
            UIImage *weather_image = [[UIImage alloc] initWithData:
                                      [NSData dataWithContentsOfURL:
                                       [NSURL URLWithString:
                                        json[@"img"]]]];
            [weather_img setImage:weather_image];
            
            forecast.text = @"Forecast:";
            f_day_t.text = @"Day";
            f_weather_t.text = @"Weather";
            f_high_t.text = @"High";
            f_low_t.text = @"Low";
            f_day_1.text = json[@"forecast"][0][@"day"];
            f_weather_1.text = json[@"forecast"][0][@"text"];
            f_high_1.text = [[NSString stringWithFormat:@"%@%@%@",
                              json[@"forecast"][0][@"high"],
                              @"\u00B0", unit] uppercaseString];
            f_low_1.text = [[NSString stringWithFormat:@"%@%@%@",
                             json[@"forecast"][0][@"low"],
                             @"\u00B0", unit] uppercaseString];
            f_day_2.text = json[@"forecast"][1][@"day"];
            f_weather_2.text = json[@"forecast"][1][@"text"];
            f_high_2.text = [[NSString stringWithFormat:@"%@%@%@",
                              json[@"forecast"][1][@"high"],
                              @"\u00B0", unit] uppercaseString];
            f_low_2.text = [[NSString stringWithFormat:@"%@%@%@",
                             json[@"forecast"][1][@"low"],
                             @"\u00B0", unit] uppercaseString];
            f_day_3.text = json[@"forecast"][2][@"day"];
            f_weather_3.text = json[@"forecast"][2][@"text"];
            f_high_3.text = [[NSString stringWithFormat:@"%@%@%@",
                              json[@"forecast"][2][@"high"],
                              @"\u00B0", unit] uppercaseString];
            f_low_3.text = [[NSString stringWithFormat:@"%@%@%@",
                             json[@"forecast"][2][@"low"],
                             @"\u00B0", unit] uppercaseString];
            f_day_4.text = json[@"forecast"][3][@"day"];
            f_weather_4.text = json[@"forecast"][3][@"text"];
            f_high_4.text = [[NSString stringWithFormat:@"%@%@%@",
                              json[@"forecast"][3][@"high"],
                              @"\u00B0", unit] uppercaseString];
            f_low_4.text = [[NSString stringWithFormat:@"%@%@%@",
                             json[@"forecast"][3][@"low"],
                             @"\u00B0", unit] uppercaseString];
            f_day_5.text = json[@"forecast"][4][@"day"];
            f_weather_5.text = json[@"forecast"][4][@"text"];
            f_high_5.text = [[NSString stringWithFormat:@"%@%@%@",
                              json[@"forecast"][4][@"high"],
                              @"\u00B0", unit] uppercaseString];
            f_low_5.text = [[NSString stringWithFormat:@"%@%@%@",
                             json[@"forecast"][4][@"low"],
                             @"\u00B0", unit] uppercaseString];
        }
        else {
            location = @"";
            valid_loc = false;
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"No results found."
                                  delegate:nil
                                  cancelButtonTitle:@"Done"
                                  otherButtonTitles:nil,
                                  nil];
            [alert show];
        }
    }
    
    if (!valid_loc) {
        location_city.text = nil;
        location_region.text = nil;
        weather_condition.text = nil;
        weather_temp.text = nil;
        weather_img.image = nil;
        
        forecast.text = nil;
        f_day_t.text = nil;
        f_weather_t.text = nil;
        f_high_t.text = nil;
        f_low_t.text = nil;
        f_day_1.text = nil;
        f_weather_1.text = nil;
        f_high_1.text = nil;
        f_low_1.text = nil;
        f_day_2.text = nil;
        f_weather_2.text = nil;
        f_high_2.text = nil;
        f_low_2.text = nil;
        f_day_3.text = nil;
        f_weather_3.text = nil;
        f_high_3.text = nil;
        f_low_3.text = nil;
        f_day_4.text = nil;
        f_weather_4.text = nil;
        f_high_4.text = nil;
        f_low_4.text = nil;
        f_day_5.text = nil;
        f_weather_5.text = nil;
        f_high_5.text = nil;
        f_low_5.text = nil;
    }
}




-(IBAction)post_weather:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebook_sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

        NSString *post = [NSString stringWithFormat:@"%@, %@, %@\nCondition:%@\nTemperature is %@\u00B0%@\nDetails on link:",
                             json[@"location"][@"city"],
                             json[@"location"][@"region"],
                             json[@"location"][@"country"],
                             json[@"condition"][@"text"],
                             json[@"condition"][@"temp"],
                             [unit uppercaseString]];
        
        [facebook_sheet setInitialText:post];
        [facebook_sheet addImage:[[UIImage alloc] initWithData:
                                  [NSData dataWithContentsOfURL:
                                   [NSURL URLWithString:json[@"img"]]]]];
        [facebook_sheet addURL:[NSURL URLWithString:json[@"link"]]];
        [self presentViewController:facebook_sheet animated:YES completion:nil];
        
        SLComposeViewControllerCompletionHandler completion = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    break;
                default:
                    break;
            }
            [facebook_sheet dismissViewControllerAnimated:YES completion:nil];
        };
        facebook_sheet.completionHandler = completion;
    }
    else {
        NSLog(@"Not avalable");
    }
}




-(IBAction)post_forecast:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebook_sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *post = [NSString stringWithFormat:@"%@, %@, %@\nCondition:%@\n%@: %@, %@/%@\u00B0%@;\n%@: %@, %@/%@\u00B0%@;\n%@: %@, %@/%@\u00B0%@;\n%@: %@, %@/%@\u00B0%@;\n%@: %@, %@/%@\u00B0%@;\nDetails on link:",
                          json[@"location"][@"city"],
                          json[@"location"][@"region"],
                          json[@"location"][@"country"],
                          json[@"condition"][@"text"],
                          json[@"forecast"][0][@"day"],
                          json[@"forecast"][0][@"text"],
                          json[@"forecast"][0][@"high"],
                          json[@"forecast"][0][@"low"],
                          [unit uppercaseString],
                          json[@"forecast"][1][@"day"],
                          json[@"forecast"][1][@"text"],
                          json[@"forecast"][1][@"high"],
                          json[@"forecast"][1][@"low"],
                          [unit uppercaseString],
                          json[@"forecast"][2][@"day"],
                          json[@"forecast"][2][@"text"],
                          json[@"forecast"][2][@"high"],
                          json[@"forecast"][2][@"low"],
                          [unit uppercaseString],
                          json[@"forecast"][3][@"day"],
                          json[@"forecast"][3][@"text"],
                          json[@"forecast"][3][@"high"],
                          json[@"forecast"][3][@"low"],
                          [unit uppercaseString],
                          json[@"forecast"][4][@"day"],
                          json[@"forecast"][4][@"text"],
                          json[@"forecast"][4][@"high"],
                          json[@"forecast"][4][@"low"],
                          [unit uppercaseString]];
        
        [facebook_sheet setInitialText:post];
        [facebook_sheet addImage:[[UIImage alloc] initWithData:
                                  [NSData dataWithContentsOfURL:
                                   [NSURL URLWithString:json[@"img"]]]]];
        [facebook_sheet addURL:[NSURL URLWithString:json[@"link"]]];
        [self presentViewController:facebook_sheet animated:YES completion:nil];
        
        SLComposeViewControllerCompletionHandler completion = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    break;
                default:
                    break;
            }
            [facebook_sheet dismissViewControllerAnimated:YES completion:nil];
        };
        facebook_sheet.completionHandler = completion;
    }
    else {
        NSLog(@"Not avalable");
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
