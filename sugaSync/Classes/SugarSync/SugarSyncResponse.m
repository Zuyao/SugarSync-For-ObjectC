//
//  SugarSyncResponse.m
//  sugaSync
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SugarSyncResponse.h"

@implementation SugarSyncResponse

@synthesize httpStatusCode = httpStatusCode_;
@synthesize responseBody = responseBody_;
@synthesize authentication = authentication_;
@synthesize headerDictionary = headerDictionary_;

- (id)initWithResponse:(NSInteger)httpStatusCode Body:(NSString *)body Headers:(NSDictionary *)header Authen:(NSString *)authen
{
    self = [super init];
    if (self) 
	{
        // init code information...
        httpStatusCode_ = httpStatusCode;
        
        if (body == nil) 
        {
            body = @"";
        }
        responseBody_ = [[NSString  alloc] initWithFormat:body];
        
        headerDictionary_ = [[NSMutableDictionary alloc] init];
        if (headerDictionary_.count != 0) 
        {
            [headerDictionary_ removeAllObjects];
        }
        [headerDictionary_ addEntriesFromDictionary:header];
        
        if (authen == nil) 
        {
            authen = @"";
        }
        authentication_ = [[NSString alloc] initWithFormat:authen];
	}
    return self;
}

- (void)dealloc
{
    // release code information...
    [responseBody_ release]; responseBody_ = nil;
    [authentication_ release]; authentication_ = nil;
    [headerDictionary_ release]; headerDictionary_ = nil;
    
    [super dealloc];
}
@end
