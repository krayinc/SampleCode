//
//  S3Config.m
//  ASIHTTPRequest
//
//  Created by Takatoshi -morimori- MORIYAMA on 10/08/19.
//  Copyright 2010 KRAY Inc. All rights reserved.
//

#import "S3Config.h"


@implementation S3Config

+(NSString *)accessKey {
  static NSString *accessKey;
  if (accessKey != nil) { return accessKey; }

  const char *accessKeyEnv = getenv("S3_ACCESS_KEY");
  accessKey = [[NSString alloc] initWithCString:accessKeyEnv];
  return accessKey;
}

+(NSString *)secretAccessKey {
  static NSString *secretAccessKey;
  if (secretAccessKey != nil) { return secretAccessKey; }
  
  const char *secretAccessKeyEnv = getenv("S3_SECRET_ACCESS_KEY");
  secretAccessKey = [[NSString alloc] initWithCString:secretAccessKeyEnv];
  return secretAccessKey;
}

@end
