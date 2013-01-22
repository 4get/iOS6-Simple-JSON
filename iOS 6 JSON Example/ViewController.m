//
//  ViewController.m
//  iOS 6 JSON Example
//
//  Created by Christopher Kuhn on 1/19/13.
//
//  Description: This is a very simple JSON example to show how to use NSJSONSerialization to parse
//  data in JSON format.
//
//  In a future tutorial I will make the request uring an NSURLConnection to handle errors and
//  privde a custom timeout.

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"JSON HIMYM";

    // Allocate Memory for the raw JSON Dictionary, and for just the tv episodes.
    jsonDict = [[NSDictionary alloc] init];
    episodes = [[NSArray alloc] init];

    // Setup the URL with the JSON URL. This url is a copy of the IMDB.
    url = [NSURL URLWithString:@"http://imdbapi.poromenos.org/json/?name=how+i+met+your+mother"];
    
    [self parseJSONWithURL:url];
}

// Parse the JSON data from the given URL
- (void) parseJSONWithURL:(NSURL *) jsonURL
{
    // Set the queue to the background queue. We will run this on the background thread to keep
    // the UI Responsive.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // Run request on background queue (thread).
    dispatch_async(queue, ^{
        NSError *error = nil;
        
        // Request the data and store in a string.
        NSString *json = [NSString stringWithContentsOfURL:jsonURL
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
        if (error == nil){
            
            // Convert the String into an NSData object.
            NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
            
            // Parse that data object using NSJSONSerialization without options.
            jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            
            // Parsing success.
            if (error == nil)
            {
                // Go back to the main thread and update the table with the json data.
                // Keeps the user interface responsive.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    episodes = [[jsonDict valueForKey:@"How I Met Your Mother"] valueForKey:@"episodes"];
                    [jsonTable reloadData];
                });
            }
            
            // Parsing failed, display error as alert.
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Uh Oh, Parsing Failed." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                
                [alertView show];
            }
        }
        
        // Request Failed, display error as alert.
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Request Error! Check that you are connected to wifi or 3G/4G with internet access." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            
            [alertView show];
        }
    });
}


// Delegate call back for cell at index path.
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    
    // Set the main label as the episode name.
    cell.textLabel.text = [[episodes objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    // Episode number and season number will be parsed as numbers. Here we're going to make a string
    // that will be used as the details label that shows the episode number and season number.
    NSNumber *seasonNum = [[episodes objectAtIndex:indexPath.row] objectForKey:@"season"];
    NSNumber *episodeNum = [[episodes objectAtIndex:indexPath.row] objectForKey:@"number"];
    NSMutableString *seasonEpisodeNum = [NSMutableString stringWithFormat:@"Season: %@ ", seasonNum];
    [seasonEpisodeNum appendString:[NSMutableString stringWithFormat:@"Ep: %@", episodeNum]];
    cell.detailTextLabel.text = seasonEpisodeNum;
    
    return cell;
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailController;
    
    // Setup a new view that will be for either iphone or ipad. This new view will show the details of
    // the cell that was tapped on (Name, season number, episode number).
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        detailController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone" bundle:[NSBundle mainBundle]];
    } else {
        detailController = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:[NSBundle mainBundle]];
    }
    
    // The new view has two strings, one for the episode name and one for the season number and episode number.
    detailController.strEpisodeDetails = [NSString stringWithString:[[[tableView cellForRowAtIndexPath:indexPath] detailTextLabel] text]];
    detailController.strEpisodeName = [NSString stringWithString:[[[tableView cellForRowAtIndexPath:indexPath] textLabel]text]];
    
    // Finally, animate in the new view that has the updated information for the cell that was tapped.
    [self.navigationController pushViewController:detailController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // ARC - Done with this view.
    detailController = nil;
}

// Only one section in this table.
-(int) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 1;
}

// Each episode will have a different name and should have its own cell.
- (int) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [episodes count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
