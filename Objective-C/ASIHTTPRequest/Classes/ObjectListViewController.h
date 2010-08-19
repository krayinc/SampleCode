//
//  ObjectListViewController.h
//  ASIHTTPRequest
//
//  Created by Takatoshi -morimori- MORIYAMA on 10/08/19.
//  Copyright 2010 KRAY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIS3Bucket.h"


@interface ObjectListViewController : UITableViewController {
  ASIS3Bucket *bucket;
  NSString *path;
  NSMutableArray *objects;
  NSMutableArray *directories;
}

@property (nonatomic,retain) ASIS3Bucket *bucket;
@property (nonatomic,retain) NSString *path;

@end
