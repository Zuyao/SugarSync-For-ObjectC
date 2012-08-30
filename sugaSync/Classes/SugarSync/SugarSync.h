//
//  SugarSync.h
//  sugaSync
//
//  Created by zuyao on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define SugarSyncPublicAccessKey    @"MTkwNTQ0NTEzMzY5Njc2ODg3ODA"
#define SugarSyncPrivateAccessKey   @"OTY4ODljOGEzNmY5NDdjMmI4MDQwMDc2YWE0NThiMTM"
#define SugarSyncTestUserName       @"fengmohuan@sina.com"
#define SugarSyncTestPassWord       @"kingxh"

#define NSStringToURL(path) [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]

#define kXMLFileTypeKey         @"XMLFileTypeKey"
#define kXMLFileNameKey         @"XMLFileNameKey"
#define kXMLFileRefKey          @"XMLFileRefKey"
#define kXMLFileContentsKey     @"XMLFileContentsKey"
#define kXMLFileSizeKey         @"XMLFileSizeKey"
#define kXMLFileDataKey         @"XMLFileDataKey"
#define kXMLFileMediaTypeKey    @"XMLFileMediaTypeKey"
#define kXMLFileLastModifiedKey @"XMLFileLastModifiedKey"

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>
#import "SugarSyncResponse.h"

@interface SugarSync : NSObject <NSURLConnectionDelegate, NSXMLParserDelegate>
{
    //SugarSyncResponse *sugarSyncResponse_;
    NSString          *authenString_;
    NSString            *xmlchar_;
    NSMutableDictionary *xmlDict_;
    NSMutableArray      *xmlInfos_;
    NSString            *xmlContentInfo_;
}

- (NSInteger)loginWithUserName:(NSString *)theUserName PassWord:(NSString *)thePassWord;
- (BOOL)uploadFile:(NSString *)fileInfo DesInfo:(NSString *)desPath ImageData:(UIImage *)imageD;
- (NSString *)createFolder:(NSString *)displayName;
- (BOOL)isExistSameFile:(NSString *)fileName InFolder:(NSString *)folderPath;
- (BOOL)isExistFolderExist:(NSString *)folderName InParentFolder:(NSString *)folderPath;

@end
