//
//  SugarSyncResponse.h
//  sugaSync
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SugarSyncResponse : NSObject
{
    NSInteger               httpStatusCode_;
    NSString                *responseBody_;
    NSString                *authentication_;
    NSMutableDictionary     *headerDictionary_;
}

@property (nonatomic, readonly) NSInteger httpStatusCode;
@property (nonatomic, readonly) NSString  *responseBody;
@property (nonatomic, readonly) NSString  *authentication;
@property (nonatomic, readonly) NSMutableDictionary *headerDictionary;

- (id)initWithResponse:(NSInteger)httpStatusCode Body:(NSString *)body Headers:(NSDictionary *)header Authen:(NSString *)authen;

@end
