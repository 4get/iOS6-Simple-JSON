//
//  DetailViewViewController.h
//  iOS 6 JSON Example
//
//  Created by Christopher Kuhn on 1/20/13.
//  Copyright (c) 2013 Christopher Kuhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    IBOutlet UILabel *lblEpisodeName;
    IBOutlet UITextView *textView;
    NSString *strEpisodeName;
    NSString *strEpisodeDetails;
}

@property (strong, nonatomic) NSString *strEpisodeName;
@property (strong, nonatomic) NSString *strEpisodeDetails;

@end
