//
//  imageDownloadingViewController.h
//  tableViewInsertANDDelete
//
//  Created by JAYAMURUGAN-PC on 2/5/14.
//  Copyright (c) 2014 JAYAMURUGAN-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface imageDownloadingViewController : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD *loading;
}
- (IBAction)deleteAction:(id)sender;
@property (strong, nonatomic) NSMutableData *array;
@property(nonatomic, assign) float length;
@property(nonatomic, strong) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *downloading;
@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *xmlbtn;
- (IBAction)xmlaction:(id)sender;
- (IBAction)action:(id)sender;
- (void)saveLocally:(NSData *)imgData;
@end
