//
//  ViewController.m
//  ImageUploader
//
//  Created by Marik on 11.11.13.
//  Copyright (c) 2013 Marik. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "AFNetworking.h"

#define dumpYourPhotoDomain @"https://api.dumpyourphoto.com/v1"
#define key @"api_key=VWMmp7FTXL7MlbJYRRyqax52O3HAYNmNVSWogPsVzzGRqUkM4lBsh3DAUTyB46Nswmr4DI2ss7ejyjSG6aXbiVGadFDRRT4jMsDo"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

-(IBAction)uploadTapped:(id)sender;

@end

@implementation ViewController

NSString *picKey;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = self.image;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.frame = CGRectMake(0.0, 0.0, 320.0, 480.0);
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.backgroundColor = [UIColor colorWithRed: 0 green:0 blue:0 alpha:0.2];
}

-(id) initWithNoteIndex:(int)index{
    self = [super init];
    if (self){
        picKey = [NSString stringWithFormat:@"picture_%i",index];
    }
    
    return self;
    
}

+(ViewController *)instance{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = (ViewController *)[sb instantiateViewControllerWithIdentifier:@"photoView"];
    return vc;
}

-(IBAction)uploadTapped:(id)sender{
    [self.view addSubview: self.activityIndicator];
    [self.activityIndicator startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData *imageData = UIImageJPEGRepresentation(self.image, 1.0);
    NSString *url = [NSString stringWithFormat:@"%@/albums/0vEDOoL3Ts/photos?%@", dumpYourPhotoDomain, key];
    NSDictionary *params = @{};
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"attachment[file]" fileName:@"picture.png" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    [self.activityIndicator stopAnimating];
        //self.tableView;
        //получить все фотки и перегрузить тэйблвью
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR");
    }];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
