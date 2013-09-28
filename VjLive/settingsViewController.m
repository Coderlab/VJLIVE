//
//  settingsViewController.m
//  VjLive
//
//  Created by Alessandro Belli on 18/09/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()

@end

@implementation settingsViewController
@synthesize buttonBackground;
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
    currentImage =@"moon";
    [buttonBackground setButtonColor:[UIColor peterRiverColor]];
    UIImage *buttonImageSun = [UIImage imageNamed:currentImage];
    [buttonBackground setBounds:CGRectMake(0, 0, 50, 50)];
    [buttonBackground setImage:buttonImageSun forState:UIControlStateNormal];
    [self.view setBackgroundColor:[UIColor peterRiverColor]];
    volumeView = [[MPVolumeView alloc] initWithFrame: CGRectMake(25, 210, self.view.frame.size.width/2, 15)];
    volumeView.showsVolumeSlider = YES;
//    [volumeView sizeToFit];
    [self.view addSubview:volumeView];
    _settingsLabel.font = [UIFont flatFontOfSize:25.0];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)changeBackgroundColour:(id)sender{

    
    [_delegate changeColor:[UIColor whiteColor]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
