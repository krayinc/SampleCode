//
//  UIDevice_extensionViewController.m
//  UIDevice-extension
//
//  Created by Takatoshi -morimori- MORIYAMA on 10/08/18.
//  Copyright 2010 KRAY Inc. All rights reserved.
//

#import "UIDevice_extensionViewController.h"
#import "UIDevice-Hardware.h"
#import "UIDevice-Orientation.h"
#import "UIDevice-Reachability.h"
#import "UIDevice-IOKitExtensions.h"
#import "CapabilityListViewController.h"


@implementation UIDevice_extensionViewController


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

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [(UITableView *)self.view reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  if (section == UIDeviceHardwareSection) {
    return 14;
  } else if (section == UIDeviceOrientationSection) {
    return 4;
  } else if (section == UIDeviceReachabilitySection) {
    return 8;
  } else if (section == UIDeviceIOKitExtensionSection) {
    return 3;
  }
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case UIDeviceHardwareSection:
      return @"Hardware";
      break;
    case UIDeviceOrientationSection:
      return @"Orientation";
      break;
    case UIDeviceReachabilitySection:
      return @"Reachability";
      break;
    case UIDeviceIOKitExtensionSection:
      return @"IOKitExtension";
      break;
    default:
      return @"";
      break;
  }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  NSString *caption;
  NSString *value;
  UIDevice *currentDevice = [UIDevice currentDevice];

  if (indexPath.section == UIDeviceHardwareSection) {
    static NSString *hardwareCellIdentifier = @"hardwareCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:hardwareCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:hardwareCellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
      caption = @"platform";
      value   = [currentDevice platform];
    } else if (indexPath.row == 1) {
      caption = @"platformType";
      value   = [NSString stringWithFormat:@"%u", [currentDevice platformType]];
    } else if (indexPath.row == 2) {
      caption = @"platformCapabilities";
      value   = [NSString stringWithFormat:@"%u", [currentDevice platformCapabilities]];
    } else if (indexPath.row == 3) {
      caption = @"platformString";
      value   = [currentDevice platformString];
    } else if (indexPath.row == 4) {
      caption = @"platformCode";
      value   = [currentDevice platformCode];
    } else if (indexPath.row == 5) {
      caption = @"capabilityArray";
      value   = @"";
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    } else if (indexPath.row == 6) {
      caption = @"platformHasCapability(RetinaDisplay)";
      if ([currentDevice platformHasCapability:UIDeviceSupportsRetinaDisplay]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else if (indexPath.row == 7) {
      caption = @"cpuFrequency";
      value   = [NSString stringWithFormat:@"%u", [currentDevice cpuFrequency]];
    } else if (indexPath.row == 8) {
      caption = @"busFrequency";
      value   = [NSString stringWithFormat:@"%u", [currentDevice busFrequency]];
    } else if (indexPath.row == 9) {
      caption = @"totalMemory";
      value   = [NSString stringWithFormat:@"%u", [currentDevice totalMemory]];
    } else if (indexPath.row == 10) {
      caption = @"userMemory";
      value   = [NSString stringWithFormat:@"%u", [currentDevice userMemory]];
    } else if (indexPath.row == 11) {
      caption = @"totalDiskSpace";
      value   = [NSString stringWithFormat:@"%u", [currentDevice totalDiskSpace]];
    } else if (indexPath.row == 12) {
      caption = @"freeDiskSpace";
      value   = [NSString stringWithFormat:@"%u", [currentDevice freeDiskSpace]];
    } else if (indexPath.row == 13) {
      caption = @"macaddress";
      value   = [currentDevice macaddress];
    } else {
      caption = @"";
      value   = @"";
    }
  } else if (indexPath.section == UIDeviceOrientationSection) {
    static NSString *orientationCellIdentifier = @"orientationCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:orientationCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orientationCellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
      caption = @"isLandscape";
      if ([currentDevice isLandscape]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else if (indexPath.row == 1) {
      caption = @"isPortrait";
      if ([currentDevice isPortrait]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else if (indexPath.row == 2) {
      caption = @"orientationString";
      value   = [currentDevice orientationString];
    } else if (indexPath.row == 3) {
      caption = @"orientationAngle";
      value   = [NSString stringWithFormat:@"%f", [currentDevice orientationAngle]];
    } else {
      caption = @"";
      value   = @"";
    }
  } else if (indexPath.section == UIDeviceReachabilitySection) {
    static NSString *reachabilityCellIdentifier = @"reachabilityCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:reachabilityCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reachabilityCellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
      caption = @"getIPAddressForHost(www.google.com)";
      value   = [currentDevice getIPAddressForHost:@"www.google.com"];
    } else if (indexPath.row == 1) {
      caption = @"localIPAddress";
      value   = [currentDevice localIPAddress];
    } else if (indexPath.row == 2) {
      caption = @"localWiFiIPAddress";
      value   = [currentDevice localWiFiIPAddress];
    } else if (indexPath.row == 3) {
      caption = @"whatismyipdotcom";
      value   = [currentDevice whatismyipdotcom];
    } else if (indexPath.row == 4) {
      caption = @"hostAvailable(www.google.com)";
      if ([currentDevice hostAvailable:@"www.google.com"]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else if (indexPath.row == 5) {
      caption = @"activeWLAN";
      if ([currentDevice activeWLAN]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else if (indexPath.row == 6) {
      caption = @"activeWWAN";
      if ([currentDevice activeWWAN]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else if (indexPath.row == 7) {
      caption = @"performWiFiCheck";
      if ([currentDevice performWiFiCheck]) {
        value = @"YES";
      } else {
        value = @"NO";
      }
    } else {
      caption = @"";
      value   = @"";
    }
  } else if (indexPath.section == UIDeviceIOKitExtensionSection) {
    static NSString *ioKitExtensionCellIdentifier = @"ioKitExtensionCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:ioKitExtensionCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ioKitExtensionCellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
      caption = @"imei";
      value   = [currentDevice imei];
    } else if (indexPath.row == 1) {
      caption = @"serialnumber";
      value   = [currentDevice serialnumber];
    } else if (indexPath.row == 2) {
      caption = @"backlightlevel";
      value   = [currentDevice backlightlevel];
    } else {
      caption = @"";
      value   = @"";
    }
  }

  cell.textLabel.text       = caption;
  cell.detailTextLabel.text = value;
  
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
  if (indexPath.section == UIDeviceHardwareSection && indexPath.row == 5) {
    CapabilityListViewController *vc = [[CapabilityListViewController alloc] initWithNibName:@"CapabilityListView" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
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
    [super dealloc];
}


@end

