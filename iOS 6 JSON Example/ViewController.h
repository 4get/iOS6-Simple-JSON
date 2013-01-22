//
//  ViewController.h
//  iOS 6 JSON Example
//
//  Created by Christopher Kuhn on 1/19/13.
//  Copyright (c) 2013 Christopher Kuhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *jsonDict;
    IBOutlet UITableView *jsonTable;
    NSArray *episodes;
    NSURL *url;
}

@end
