//
//  delegateViewController.m
//  tableViewInsertANDDelete
//
//  Created by Subramani B R on 3/26/14.
//  Copyright (c) 2014 JAYAMURUGAN-PC. All rights reserved.
//

#import "delegateViewController.h"

@interface delegateViewController ()<UITextFieldDelegate>
@end

@implementation delegateViewController
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
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
    NSLog(@"%@",self.string);
    textField=[[UITextField alloc]init];
    textField.frame=CGRectMake(self.view.bounds.origin.x+100, self.view.bounds.origin.y+100, 100, 50);
    [textField setText:self.string];
    buttonAction=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonAction.frame=CGRectMake(self.view.bounds.origin.x+100, self.view.bounds.origin.y+200, 100, 50);
    [buttonAction setTitle:@"Delegate" forState:UIControlStateNormal];
    [buttonAction setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonAction addTarget:self action:@selector(delegateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:textField];
    [self.view addSubview:buttonAction];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delegateAction:(id)sender
{
    [self.delegate selectedName:textField.text index:[NSString stringWithFormat:@"%d",self.index]];
    [[self navigationController]popViewControllerAnimated:YES];
}
@end
