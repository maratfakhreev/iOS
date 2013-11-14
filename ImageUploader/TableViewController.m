//
//  TableViewController.m
//  ImageUploader
//
//  Created by Marik on 11.11.13.
//  Copyright (c) 2013 Marik. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "Picture.h"

@interface TableViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UIBarButtonItem *getPhotoButton;
@property (nonatomic, strong) NSArray *picArray;
-(IBAction) getPhoto;

@end

@implementation TableViewController{
    int photosCount;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self getPicturesFromDatabase];
}

-(void) getPhoto{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open photolibrary", @"Take Photo", nil];
    [sheet showInView:self.view];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];

    ViewController *controller = [ViewController instance];
    controller.image = image;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex <= 1){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = buttonIndex == 0 ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera;
        
        controller.delegate = self;
        
        [self presentViewController:controller animated:YES completion:^{}];
    }
}


- (void) addTapped{
    ViewController *controller = [[ViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)getPicturesFromDatabase {
    self.picArray = [[Picture findAllPictures] mutableCopy];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Testing";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewController *controller = [[ViewController alloc] initWithNoteIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
