//
//  imageDownloadingViewController.m
//  tableViewInsertANDDelete
//
//  Created by JAYAMURUGAN-PC on 2/5/14.
//  Copyright (c) 2014 JAYAMURUGAN-PC. All rights reserved.
//

#import "imageDownloadingViewController.h"
#import "ViewController.h"
@interface imageDownloadingViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation imageDownloadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array = [[NSMutableData alloc]init];
    CGRect frame = CGRectMake (120.0, 170.0, 80, 80);
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    
    [self.view addSubview:self.activityIndicatorView];

    // Do any additional setup after loading the view from its nib.
   //
}
//@"http://i413.photobucket.com/albums/pp215/ylva51/nature/nature_017.jpg"
//http://www.raincoast.org/wp-content/uploads/S1I1596grizzlysittingattideline547-10MB.jpg

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma connectionclass delegates


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%lld",[response expectedContentLength]);

    self.length = [response expectedContentLength];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.array appendData:data];
    NSLog(@"%f",(float)[self.array length]);
    NSLog(@"%f",(float)self.length);

   float progress =  (float)[self.array length]/(float)self.length;
    NSLog(@"%f",progress);

    self.timeLabel.text = [NSString stringWithFormat:@"%0.2f%%",progress*100];
    
    if ([self.timeLabel.text integerValue]==100) {
     [self.activityIndicatorView stopAnimating];
       // [loading hide:YES];
//        UIAlertView *alr=[[UIAlertView alloc]initWithTitle:@"Completed!" message:@"Do You Want to go back?" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"No", nil];
//        [alr show];
    }
    
    [self.progressView setProgress:progress animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
            if (alertView.tag==0)
           {
               [self presentViewController:[[ViewController alloc]init] animated:YES completion:nil];
           }
            else
            {
                [self presentViewController:self animated:YES completion:nil];
    
           }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError%@",error);
    [self performSelector:@selector(showIndi) withObject:nil afterDelay:3.0];

}
-(void)showIndi
{
    [self.activityIndicatorView stopAnimating];
  
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *img = [UIImage imageWithData:self.array];
    self.imageView.image = img;
    [self saveLocally:self.array];
}


#pragma storing images
-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *) picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)urlencode:(NSString *)str
{
    NSString *encodeString=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)str, NULL, (CFStringRef)@"", kCFStringEncodingUTF8));
    return encodeString;
}

- (IBAction)xmlaction:(id)sender {
    
    if ([NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self urlencode:@"http://i413.photobucket.com/albums/pp215/ylva51/nature/nature_017.jpg"]]]delegate:self])
    {
        [self.activityIndicatorView startAnimating];
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//        loading=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        loading.progress=MBProgressHUDAnimationFade;
//        [loading setLabelText:@"Testing"];

    }
}
//http://i413.photobucket.com/albums/pp215/ylva51/nature/nature_017.jpg
//http://www.pupsbook.com/m_.php?cmd=getFeed&offset=0&limit=100&userID=5&device=ios&status=active&latestDate=
- (IBAction)action:(id)sender {
    
    
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
       
    }
}

- (void)saveLocally:(NSData *)imgData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *aDate = [NSDate date];
    NSTimeInterval interval = [aDate timeIntervalSince1970];
    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.jpeg",(int)interval]];
    NSLog(@"%@",localFilePath);
    [imgData writeToFile:localFilePath atomically:YES];
    
    
    
    }
- (IBAction)deleteAction:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        NSLog(@"Directory: %@", directory);
        
        // For each file in the directory, create full path and delete the file
        for (NSString *file in [fileManager contentsOfDirectoryAtPath:directory error:&error])
        {
            NSString *filePath = [directory stringByAppendingPathComponent:file];
            NSLog(@"File : %@", filePath);
            
            BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
            
            if (fileDeleted != YES || error != nil)
            {
                // Deal with the error...
            }
            NSLog(@"File Dleted");

        }
        
    }

    
}
@end
