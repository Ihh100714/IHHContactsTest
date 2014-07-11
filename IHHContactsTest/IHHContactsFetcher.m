//
//  IHHContactsFetcher.m
//  IHHContactsTest
//
//  Created by Ismail on 11/07/2014.
//  Copyright (c) 2014 Monitise. All rights reserved.
//

#import "IHHContactsFetcher.h"
#import "IHHAppDelegate.h"
#import "Contact.h"
static IHHContactsFetcher *shared = nil;

@interface IHHContactsFetcher () <NSXMLParserDelegate>
{
    NSOperationQueue *_queue;
    NSXMLParser * _parser;
    NSMutableString* foundString;
    Contact * currentContact;
}
@end
@implementation IHHContactsFetcher

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [IHHContactsFetcher new];
    });
    return shared;
}

- (instancetype)init {
    if((self = [super init])) {
        _queue = [NSOperationQueue new];
        NSManagedObjectContext *MOC = [(IHHAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        _privateContext = [[NSManagedObjectContext alloc] init];
        [_privateContext setPersistentStoreCoordinator:[MOC persistentStoreCoordinator]];

    }
    return self;
}


- (void)fetchContacts:(void(^)(bool done)) block {
    
    NSString* dataURL = @"http://demo.monitise.net/download/tests/Data.xml";
    NSURL *url = [NSURL URLWithString: dataURL];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: _queue
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(data && !error)
         {
             NSFetchRequest *request = [[NSFetchRequest alloc] init];
             [request setEntity:[NSEntityDescription entityForName:@"Contact" inManagedObjectContext:_privateContext]];
             [request setIncludesPropertyValues:NO];
             error = nil;
             NSArray *oldContacts = [_privateContext executeFetchRequest:request error:&error];
             if (!error) {
                 for (Contact *contact in oldContacts) {
                     [_privateContext deleteObject:contact];
                 }
             }
             //start parsing data.
             _parser = [[NSXMLParser alloc] initWithData:data];
             _parser.delegate = self;
             [_parser parse];
             
         }
         
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             block(YES);
         });
     }];
}


- (void)fetchImageFromURL:(NSString *)imageUrl completion:(void(^)(UIImage *image, NSString *uri, NSError *error)) block
{
    NSParameterAssert(imageUrl);
    NSParameterAssert(block);
    
    NSURL *url = [NSURL URLWithString: imageUrl];
    
    NSString *hash = [NSString stringWithFormat: @"%016lx", (unsigned long)[imageUrl hash]];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: hash];
    
    // check whether we have a cached version of the image we can return straight away
    
    UIImage *image = nil;
    NSData *data = [NSData dataWithContentsOfFile: path options: NSDataReadingMappedIfSafe error: NULL];
    if(data && (image = [UIImage imageWithData: data])) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(image,imageUrl,nil);
        });
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: _queue
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         UIImage *image = nil;
         
         if(data) {
             // save it to the cache directory
             NSError *err = nil;
             if(![data writeToFile: path options: NSDataWritingAtomic error: &err]) {
                 NSLog(@"couldn't write image to cache at '%@': %@", path, err);
             }
             image = [UIImage imageWithData: data];
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             block(image,imageUrl,connectionError);
         });
     }];
}
#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"contact"])
    {
        currentContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact"inManagedObjectContext:_privateContext];
    }
    foundString=nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!foundString) {
        foundString = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [foundString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"contact"]) {
        NSError *error;
        if (![_privateContext save:&error]) {
            NSLog(@"Failed to save Contact");
            currentContact=nil;
            
        }
    }
    
    else if (![elementName isEqualToString:@"contacts"])
    {
        
       
        if ([elementName isEqualToString:@"picture"])
        {
            currentContact.pictureURL = foundString;
        }
        else
        {
            [currentContact setValue:foundString forKeyPath:elementName];

        }
    }
    foundString=nil;

}


@end
