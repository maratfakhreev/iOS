//
//  imageCacher.m
//  TwitterParser
//
//  Created by Marik on 24.10.13.
//  Copyright (c) 2013 Danis Ziganshin. All rights reserved.
//

#import "imageCacher.h"

@implementation imageCacher: NSObject

+(imageCacher *)sharedCacher{
    static dispatch_once_t once;
    static imageCacher *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[imageCacher alloc] init];
        sharedInstance.images = [NSMutableDictionary dictionary];
    });
    return sharedInstance;
}

-(void) setImage:(UIImage *)img  forURL:(NSString *)urlString{
//    NSData *data = UIImagePNGRepresentation(img);
    [self.images setObject:img forKey:urlString];
}

-(UIImage *)getImageForURL:(NSString *)urlString{
    return [self.images objectForKey:urlString];
}

@end
