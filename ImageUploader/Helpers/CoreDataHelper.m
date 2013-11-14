//
//  CoreDataHelper.m
//  TwitterParser
//
//  Created by Danis Ziganshin on 31.10.13.
//  Copyright (c) 2013 Danis Ziganshin. All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>

#define PERSISTENCE_STORE_URL @"TwitterParser.sqlite"
#define MODEL_NAME @"TwitterParser"

@interface CoreDataHelper ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation CoreDataHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CoreDataHelper *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataHelper alloc] init];
    });
    return sharedInstance;
}

//+ (NSManagedObjectContext *)sharedContext {
//    return [CoreDataHelper sharedInstance].moc;
//}

- (id)init {
    if (self=[super init]) {
        self.persistentStoreCoordinator = [self createPersistentStoreCoordinator];
        self.moc = [self createContext];
    }
    return self;
}

#pragma mark - Private methods

- (NSPersistentStoreCoordinator *)createPersistentStoreCoordinator {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:MODEL_NAME withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSURL *appDirectoryURL = (NSURL *)[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [appDirectoryURL URLByAppendingPathComponent:PERSISTENCE_STORE_URL];
    NSError *error = nil;
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES};
    
    NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                         configuration:nil
                                                                   URL:storeURL
                                                               options:options
                                                                 error:&error];
    if (store==nil) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:storeURL
                                        options:options
                                          error:&error];
    }
    
    return coordinator;
}

- (NSManagedObjectContext *)createContext {
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    return context;
}


@end
