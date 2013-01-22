//
//  DetailViewViewController.m
//  iOS 6 JSON Example
//
//  Created by Christopher Kuhn on 1/20/13.
//  Copyright (c) 2013 Christopher Kuhn. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize strEpisodeDetails;
@synthesize strEpisodeName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        lblEpisodeName = [[UILabel alloc] init];
        textView = [[UITextView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Details";
    lblEpisodeName.text = strEpisodeName;
    textView.text = strEpisodeDetails;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
