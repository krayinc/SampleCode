//
//  ObjectListViewController.m
//  ASIHTTPRequest
//
//  Created by Takatoshi -morimori- MORIYAMA on 10/08/19.
//  Copyright 2010 KRAY Inc. All rights reserved.
//

#import "ObjectListViewController.h"
#import "ASIS3BucketRequest.h"
#import "S3Config.h"
#import "ASIS3BucketObject.h"


@implementation ObjectListViewController

@synthesize bucket;
@synthesize path;


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = [NSString stringWithFormat:@"%@:/%@", bucket.name, path];

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  ASIS3BucketRequest *request = [ASIS3BucketRequest requestWithBucket:bucket.name];
  request.accessKey       = [S3Config accessKey];
  request.secretAccessKey = [S3Config secretAccessKey];
  request.delimiter       = @"/";
  request.prefix          = path;
  [request startSynchronous];
  if (![request error]) {
    directories = [[NSMutableArray alloc] init];
    objects     = [[NSMutableArray alloc] init];
    
    NSRange range = NSMakeRange(0, [path length]);
    for (NSString *directory in request.commonPrefixes) {
      [directories addObject:[directory stringByReplacingCharactersInRange:range withString:@""]];
    }
    for (ASIS3BucketObject *object in request.objects) {
      if ([object.key length] > 9 && [[object.key substringFromIndex:([object.key length] - 9)] isEqualToString:@"_$folder$"]) { continue; }
      object.key = [object.key stringByReplacingCharactersInRange:range withString:@""];
      [objects addObject:object];
    }
  } else {
    directories = [[NSArray alloc] init];
    objects     = [[NSArray alloc] init];
  }
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return [directories count];
  } else {
    return [objects count];
  }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  if (indexPath.section == 0) {
    static NSString *directoryCellIdentifier = @"S3DirectoryCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:directoryCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:directoryCellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSString *directory = [directories objectAtIndex:indexPath.row];
    cell.textLabel.text = directory;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  } else {
    static NSString *objectCellIdentifier = @"S3ObjectCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:objectCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:objectCellIdentifier] autorelease];
    }
    
    // Configure the cell...
    ASIS3BucketObject *object = [objects objectAtIndex:indexPath.row];
    cell.textLabel.text = object.key;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterMediumStyle];
    cell.detailTextLabel.text = [fmt stringFromDate:object.lastModified];
    [fmt release];
  }    
  
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    ObjectListViewController *vc = [[ObjectListViewController alloc] initWithNibName:@"ObjectListView" bundle:nil];
    vc.bucket = bucket;
    vc.path   = [NSString stringWithFormat:@"%@%@", path, [directories objectAtIndex:indexPath.row]];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
  } else {
/*
 ObjectViewController *vc = [[ObjectViewController alloc] initWithNibName:@"ObjectView" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
 */
  }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
  [bucket release];
  [objects release];
  [directories release];
  [path release];
  [super dealloc];
}


@end

