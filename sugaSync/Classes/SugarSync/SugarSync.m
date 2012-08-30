//
//  SugarSync.m
//  sugaSync
//
//  Created by zuyao on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SugarSync.h"
#import "sugaSyncAppDelegate.h"
#import <AVFoundation/AVFoundation.h>


@implementation SugarSync

- (id)init
{
    self = [super init];
    if (self) 
	{
        // init informations...
        xmlchar_ = [[NSString alloc] init];
        xmlInfos_ = [[NSMutableArray alloc] init];
	}
    
    return self;
}

- (void)dealloc
{
    // release informations...
    if (authenString_ != nil) 
	{
        [authenString_ release]; authenString_ = nil;
	}
    if (xmlchar_ != nil) 
	{
        [xmlchar_ release]; xmlchar_ = nil;
	}
    if (xmlDict_ != nil) 
	{
        [xmlDict_ release]; xmlDict_ = nil;
	}
    if (xmlInfos_ != nil) 
	{
        [xmlInfos_ release]; xmlInfos_ = nil;
	}
    
    [super dealloc];
}

#pragma mark -
#pragma mark Private Methods
- (NSString *)sizeToString:(CGFloat)scale
{
    NSString *str = nil;
    
    NSInteger step = 0;
    while (scale > 1024) 
	{
        scale = truncf(scale / 1024);
        step++;
	}
    
    NSInteger result = scale;
    switch (step) 
	{
        case 0:
    		str = [NSString stringWithFormat:@"%dB",result];
    		break;
        case 1:
            str  = [NSString stringWithFormat:@"%dK",result];
            break;
        case 2:
            str  = [NSString stringWithFormat:@"%dM",result];
            break;
        case 3:
            str  = [NSString stringWithFormat:@"%dG",result];
            break;
        case 4:
            str  = [NSString stringWithFormat:@"%dT",result];
            break;
  		default:
    		break;
	}
    
    return str;
}

- (SugarSyncResponse *)uploadFile:(NSString *)desPath FileData:(NSData *)fileData Authen:(NSString *)authorization
{
    SugarSyncResponse *sugarSyncResponse = nil;
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:NSStringToURL(desPath)];
    [request setHTTPMethod:@"PUT"];
    
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"SugarSync API Sample/1.0" forHTTPHeaderField:@"User-Agent"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:fileData];
    [request setHTTPBody:body];
    
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSInteger stutsCode = 0;
    NSString *responseString = nil;
    NSDictionary *dicHeader = nil;
    
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    stutsCode = [(NSHTTPURLResponse *)urlResponse statusCode];
    dicHeader = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
    
    sugarSyncResponse = [[SugarSyncResponse alloc] initWithResponse:stutsCode
                                                               Body:responseString
                                                            Headers:dicHeader
                                                             Authen:authorization];
    [responseString release];
    
    return [sugarSyncResponse autorelease];
}

- (SugarSyncResponse *)createFile:(NSString *)folderPath DisplayName:(NSString *)displayName MediaType:(NSString *)mediaType Authen:(NSString *)authorization
{
    SugarSyncResponse *sugarSyncResponse = nil;

    NSString *requestString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><file><displayName>%@</displayName><mediaType>%@</mediaType></file>",displayName,mediaType];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:NSStringToURL(folderPath)];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"SugarSync API Sample/1.0" forHTTPHeaderField:@"User-Agent"];
    
    NSMutableData *body = [NSMutableData data];
    [body setData:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSInteger stutsCode = 0;
    NSString *responseString = nil;
    NSDictionary *dicHeader = nil;
    
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    stutsCode = [(NSHTTPURLResponse *)urlResponse statusCode];
    dicHeader = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
    
    sugarSyncResponse = [[SugarSyncResponse alloc] initWithResponse:stutsCode
                                                               Body:responseString
                                                            Headers:dicHeader
                                                             Authen:authorization];
    [responseString release];
    
    return [sugarSyncResponse autorelease];
}

- (SugarSyncResponse *)createFolder:(NSString *)responsePath FolderName:(NSString *)folderName Authen:(NSString *)authorization
{
    SugarSyncResponse *sugarSyncResponse = nil;
    
    NSString *requestString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><folder><displayName>%@</displayName></folder>",folderName];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:NSStringToURL(responsePath)];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"SugarSync API Sample/1.0" forHTTPHeaderField:@"User-Agent"];
    
    NSMutableData *body = [NSMutableData data];
    [body setData:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSInteger stutsCode = 0;
    NSString *responseString = nil;
    NSDictionary *dicHeader = nil;
    
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    stutsCode = [(NSHTTPURLResponse *)urlResponse statusCode];
    dicHeader = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
    
    sugarSyncResponse = [[SugarSyncResponse alloc] initWithResponse:stutsCode
                                                               Body:responseString
                                                            Headers:dicHeader
                                                             Authen:authorization];
    [responseString release];

    return [sugarSyncResponse autorelease];
}

- (SugarSyncResponse *)userInfo:(NSString *)authorization ResponseAddress:(NSString *)addressString
{
    SugarSyncResponse *sugarSyncResponse = nil;
    
    //NSString *addressString = @"https://api.sugarsync.com/user";
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:NSStringToURL(addressString)];
    [request setHTTPMethod:@"GET"];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"SugarSync API Sample/1.0" forHTTPHeaderField:@"User-Agent"];
    
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSInteger stutsCode = 0;
    NSString *responseString = nil;
    NSDictionary *dicHeader = nil;
    
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    stutsCode = [(NSHTTPURLResponse *)urlResponse statusCode];
    dicHeader = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
        
    sugarSyncResponse = [[SugarSyncResponse alloc] initWithResponse:stutsCode
                                                               Body:responseString
                                                            Headers:dicHeader
                                                             Authen:authorization];
    [responseString release];
    return [sugarSyncResponse autorelease];
}

- (SugarSyncResponse *)authorizationToken:(NSString *)userName PassWord:(NSString *)passWord AccessKey:(NSString *)accessKey PrivateAccessKey:(NSString *)pAccessKey
{
    NSString *requestString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><authRequest><username>%@</username><password>%@</password><accessKeyId>%@</accessKeyId><privateAccessKey>%@</privateAccessKey></authRequest>",userName,passWord,accessKey,pAccessKey];
    NSString *addressString = @"https://api.sugarsync.com/authorization";    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:NSStringToURL(addressString)];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"SugarSync API Sample/1.0" forHTTPHeaderField:@"User-Agent"];
    
    NSMutableData *body = [NSMutableData data];
    [body setData:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *authen = nil;
    NSInteger stutsCode = 0;
    NSString *responseString = nil;
    NSDictionary *dicHeader = nil;
    
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    stutsCode = [(NSHTTPURLResponse *)urlResponse statusCode];
    dicHeader = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
    if (!error) 
    {
        authen = [[(NSHTTPURLResponse *)urlResponse allHeaderFields] objectForKey:@"Location"];
    }
    
    SugarSyncResponse *sugarSyncResponse = [[SugarSyncResponse alloc] initWithResponse:stutsCode
                                                                                  Body:responseString
                                                                               Headers:dicHeader
                                                                                Authen:authen];
    [responseString release];
    
    return [sugarSyncResponse autorelease];
}

- (NSString *)responseAddress:(NSString *)authorization DisplayName:(NSString *)displayName
{
    SugarSyncResponse *sugarSyncResponse = nil;
    NSString *responseString = nil;
    
    // get Web Archive Folder Link Address...
    NSString *magicLink = nil;
    if (sugarSyncResponse != nil) 
	{
        sugarSyncResponse = nil;
	}
    sugarSyncResponse = [self userInfo:authorization ResponseAddress:@"https://api.sugarsync.com/user"];
    responseString = sugarSyncResponse.responseBody;
    
    NSRange magicRange = [responseString rangeOfString:@"webArchive>"]; //webArchive magicBriefcase
    if (magicRange.length != 0) 
	{
        NSArray *stringArray = [responseString componentsSeparatedByString:@"webArchive>"]; //webArchive
        magicLink = [stringArray objectAtIndex:1];
        magicLink = [magicLink substringWithRange:NSMakeRange(0, magicLink.length - 2)];
	}
    
    NSString *photoTapLinkPath = nil;
    if (![self isExistFolderExist:@"Photo Tap" InParentFolder:magicLink]) 
	{
        if (sugarSyncResponse != nil) 
        {
            sugarSyncResponse = nil;
        }
        
        sugarSyncResponse = [self createFolder:magicLink FolderName:@"Photo Tap" Authen:authorization];
        photoTapLinkPath = [sugarSyncResponse.headerDictionary objectForKey:@"Location"];
	}
    else
    {
        if (xmlInfos_.count != 0) 
        {
            for (NSMutableDictionary *dic in xmlInfos_) 
            {
                if ([@"folder" isEqualToString:[dic objectForKey:kXMLFileTypeKey]]) 
                {
                    if ([@"Photo Tap" isEqualToString:[dic objectForKey:kXMLFileNameKey]]) 
                    {
                        photoTapLinkPath = [dic objectForKey:kXMLFileRefKey];
                        break;
                    }
                }
            }
        }
    }
    
    NSString *desLinkPath = nil;
    if (![self isExistFolderExist:displayName InParentFolder:photoTapLinkPath]) 
	{
        if (sugarSyncResponse != nil) 
        {
            sugarSyncResponse = nil;
        }
        sugarSyncResponse = [self createFolder:photoTapLinkPath FolderName:displayName Authen:authorization];
        desLinkPath = [sugarSyncResponse.headerDictionary objectForKey:@"Location"];
	}
    else
    {
        if (xmlInfos_.count != 0) 
        {
            for (NSMutableDictionary *dic in xmlInfos_) 
            {
                if ([[dic objectForKey:kXMLFileTypeKey] isEqualToString:@"folder"]) 
                {
                    if ([displayName isEqualToString:[dic objectForKey:kXMLFileNameKey]]) 
                    {
                        desLinkPath = [dic objectForKey:kXMLFileRefKey];
                        break;
                    }
                }
            }
        }
    }
    
    return desLinkPath;
}

- (NSInteger)handleUploadCommand:(NSString *)authorization FileInfo:(NSString *)fileInfo DesInfo:(NSString *)desPath FileData:(NSData *)fileData 
{
    SugarSyncResponse *sugarSyncResponse = nil;
    
    // Create New File for upload...
    if (sugarSyncResponse != nil) 
	{
        sugarSyncResponse = nil;
	}
    sugarSyncResponse = [self createFile:desPath DisplayName:fileInfo MediaType:@"" Authen:authorization];
    NSString *fileDataURL = [[sugarSyncResponse.headerDictionary objectForKey:@"Location"] stringByAppendingString:@"/data"];
    
    // Do upload...
    if (sugarSyncResponse != nil) 
	{
        sugarSyncResponse = nil;
	}
    sugarSyncResponse = [self uploadFile:fileDataURL FileData:fileData Authen:authorization];

    if (sugarSyncResponse.httpStatusCode != 204) 
	{
        return 0;
	}
    return 1;
}

#pragma mark -
#pragma mark Public Method
- (NSInteger)loginWithUserName:(NSString *)theUserName PassWord:(NSString *)thePassWord
{
    SugarSyncResponse *sugarSyncResponse = [self authorizationToken:theUserName 
                                                           PassWord:thePassWord 
                                                          AccessKey:SugarSyncPublicAccessKey 
                                                   PrivateAccessKey:SugarSyncPrivateAccessKey];
    authenString_ = [sugarSyncResponse.authentication copy];
    if (sugarSyncResponse.httpStatusCode > 299) 
	{
        NSLog(@"Error while getting authorization token!");
        return 0;
	}
    
    
    // 1. create folder
    NSString *desPath = [self createFolder:@"郑龙。。，，iPad"]; // testFolder
    
    // 2. check file was exist or not exist.
    BOOL isExist = [self isExistSameFile:@"a.bmp" InFolder:desPath];
    NSLog(@"isExist: %d",isExist);
    
    // 3. do upload https://api.sugarsync.com/folder/:sc:3145992:1
    UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/zuyao/Desktop/a.jpg"];  //IcTSX.jpg
    [self uploadFile:@"e.bmp"
             DesInfo:desPath
           ImageData:image];
    
    return 1;
}

- (BOOL)uploadFile:(NSString *)fileInfo DesInfo:(NSString *)desPath ImageData:(UIImage *)imageD
{
    BOOL isSuccess = NO;
    
    NSInteger result = [self handleUploadCommand:authenString_ 
                                        FileInfo:fileInfo
                                         DesInfo:desPath
                                        FileData:UIImagePNGRepresentation(imageD)];
    
    if (result == 0) 
	{
        NSLog(@"Error was not perform upload...");
        return isSuccess;
	}
    
    isSuccess = YES;
    return isSuccess;
}

- (NSString *)createFolder:(NSString *)displayName
{
    return [self responseAddress:authenString_ DisplayName:displayName];
}

- (BOOL)isExistSameFile:(NSString *)fileName InFolder:(NSString *)folderPath
{
    BOOL isExist = NO;
    
    // check same file exist.
    SugarSyncResponse *sugarSyncResponse = nil;
    NSString *responseString = nil;
    
    sugarSyncResponse = [self userInfo:authenString_ ResponseAddress:folderPath];
    responseString = sugarSyncResponse.responseBody;
    
    NSString *contentLink = nil;
    NSRange contentRange = [responseString rangeOfString:@"contents>"]; //webArchive magicBriefcase
    if (contentRange.length != 0) 
	{
        NSArray *stringArray = [responseString componentsSeparatedByString:@"contents>"]; //webArchive
        contentLink = [stringArray objectAtIndex:1];
        contentLink = [contentLink substringWithRange:NSMakeRange(0, contentLink.length - 2)];
	}
    //NSLog(@"link: %@",contentLink);
    
    if (sugarSyncResponse != nil) 
	{
        sugarSyncResponse = nil;
	}
    sugarSyncResponse = [self userInfo:authenString_ ResponseAddress:contentLink];
    responseString = sugarSyncResponse.responseBody;
    
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]] autorelease];
    [parser setDelegate:self];
    [xmlInfos_ removeAllObjects];
    [parser parse];
    //NSLog(@"xmlInfo: %@",xmlInfos_);
    
    if (xmlInfos_.count != 0) 
	{
        for (NSMutableDictionary *dic in xmlInfos_) 
        {
            if ([@"file" isEqualToString:[dic objectForKey:kXMLFileTypeKey]]) 
            {
                if ([fileName isEqualToString:[dic objectForKey:kXMLFileNameKey]])
                {
                    isExist = YES;
                    break;
                }
            }
        }
	}
    
    return isExist;
}

- (BOOL)isExistFolderExist:(NSString *)folderName InParentFolder:(NSString *)folderPath
{
    BOOL isExist = NO;
    
    SugarSyncResponse *sugarSyncResponse = nil;
    NSString *responseString = nil;
    
    sugarSyncResponse = [self userInfo:authenString_ ResponseAddress:folderPath];
    responseString = sugarSyncResponse.responseBody;
    
    NSString *contentLink = nil;
    NSRange contentRange = [responseString rangeOfString:@"contents>"]; //webArchive magicBriefcase
    if (contentRange.length != 0) 
	{
        NSArray *stringArray = [responseString componentsSeparatedByString:@"contents>"]; //webArchive
        contentLink = [stringArray objectAtIndex:1];
        contentLink = [contentLink substringWithRange:NSMakeRange(0, contentLink.length - 2)];
	}
    //NSLog(@"link: %@",contentLink);
    
    if (sugarSyncResponse != nil) 
	{
        sugarSyncResponse = nil;
	}
    sugarSyncResponse = [self userInfo:authenString_ ResponseAddress:contentLink];
    responseString = sugarSyncResponse.responseBody;
    
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]] autorelease];
    [parser setDelegate:self];
    [xmlInfos_ removeAllObjects];
    [parser parse];
    //NSLog(@"xmlInfo: %@",xmlInfos_);
    
    if (xmlInfos_.count != 0) 
	{
        for (NSMutableDictionary *dic in xmlInfos_) 
        {
            if ([@"folder" isEqualToString:[dic objectForKey:kXMLFileTypeKey]]) 
            {
                if ([folderName isEqualToString:[dic objectForKey:kXMLFileNameKey]])
                {
                    isExist = YES;
                    break;
                }
            }
        }
	}
    
    return isExist;
}

#pragma mark -
#pragma mark XMLParser Delegate Method
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (xmlchar_ != nil) 
	{
        [xmlchar_ release];
        xmlchar_ = nil;
	}
    
    if ([elementName isEqualToString:@"collection"]) 
	{
        NSString *type = [attributeDict objectForKey:@"type"];
        xmlDict_ = [[NSMutableDictionary dictionary] retain];
        [xmlDict_ setObject:type forKey:kXMLFileTypeKey];
	}
    if ([elementName isEqualToString:@"file"]) 
	{
        NSString *type = @"file";
        xmlDict_ = [[NSMutableDictionary dictionary] retain];
        [xmlDict_ setObject:type forKey:kXMLFileTypeKey];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
    xmlchar_ = [string copy];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"displayName"]) 
	{
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileNameKey];
	}
    else if ([elementName isEqualToString:@"ref"])
    {
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileRefKey];
    }
    else if ([elementName isEqualToString:@"contents"])
    {
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileContentsKey];
    }
    else if ([elementName isEqualToString:@"collection"])
    {
        [xmlInfos_ addObject:xmlDict_];
        [xmlDict_ release];
        xmlDict_ = nil;
    }
    else if ([elementName isEqualToString:@"size"])
    {
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileSizeKey];
    }
    else if ([elementName isEqualToString:@"lastModified"])
    {
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileLastModifiedKey];
    }
    else if ([elementName isEqualToString:@"mediaType"])
    {
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileMediaTypeKey];
    }
    else if ([elementName isEqualToString:@"fileData"])
    {
        [xmlDict_ setObject:xmlchar_ forKey:kXMLFileDataKey];
    }
    else if ([elementName isEqualToString:@"file"])
    {
        [xmlInfos_ addObject:xmlDict_];
        [xmlDict_ release];
        xmlDict_ = nil;
    }
}

@end
