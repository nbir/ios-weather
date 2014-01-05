//
//  NibirViewController.h
//  weather
//
//  Created by Nibir Bora on 12/4/13.
//  Copyright (c) 2013 Nibir Bora. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NibirViewController : UIViewController {
    IBOutlet UITextField *location_input;
    IBOutlet UISegmentedControl *unit_type;
    IBOutlet UILabel *location_city;
    IBOutlet UILabel *location_region;
    IBOutlet UILabel *weather_condition;
    IBOutlet UILabel *weather_temp;
    IBOutlet UIImageView *weather_img;
    
    IBOutlet UILabel *forecast;
    IBOutlet UILabel *f_day_t;
    IBOutlet UILabel *f_weather_t;
    IBOutlet UILabel *f_high_t;
    IBOutlet UILabel *f_low_t;
    IBOutlet UILabel *f_day_1;
    IBOutlet UILabel *f_weather_1;
    IBOutlet UILabel *f_high_1;
    IBOutlet UILabel *f_low_1;
    IBOutlet UILabel *f_day_2;
    IBOutlet UILabel *f_weather_2;
    IBOutlet UILabel *f_high_2;
    IBOutlet UILabel *f_low_2;
    IBOutlet UILabel *f_day_3;
    IBOutlet UILabel *f_weather_3;
    IBOutlet UILabel *f_high_3;
    IBOutlet UILabel *f_low_3;
    IBOutlet UILabel *f_day_4;
    IBOutlet UILabel *f_weather_4;
    IBOutlet UILabel *f_high_4;
    IBOutlet UILabel *f_low_4;
    IBOutlet UILabel *f_day_5;
    IBOutlet UILabel *f_weather_5;
    IBOutlet UILabel *f_high_5;
    IBOutlet UILabel *f_low_5;
}

-(IBAction)hide_keyboard:(id)sender;
-(IBAction)unit_selector:(id)sender;
-(IBAction)search_button:(id)sender;
-(IBAction)post_weather:(id)sender;
-(IBAction)post_forecast:(id)sender;

@end
