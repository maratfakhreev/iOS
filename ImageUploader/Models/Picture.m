//
//  Picture.m
//  ImageUploader
//
//  Created by Marik on 11.11.13.
//  Copyright (c) 2013 Marik. All rights reserved.
//

#import "Picture.h"
#import "CoreDataHelper.h"

@implementation Picture

@dynamic hash;
@dynamic title;
@dynamic url;

-(void) setupWithDictionary:(NSDictionary *)dict  {
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;

    self.hash = [dict objectForKey:@"hash"];
    self.title = [dict objectForKey:@"title"];
    self.url = [dict objectForKey:@"url"];
}

+(NSArray *)findAllPictures {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Picture"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    return [[CoreDataHelper sharedInstance].moc executeFetchRequest:fetchRequest error:nil];
}

@end
