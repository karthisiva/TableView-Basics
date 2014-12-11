//
//  ViewController.m
//  tableViewInsertANDDelete
//
//  Created by JAYAMURUGAN-PC on 2/5/14.
//  Copyright (c) 2014 JAYAMURUGAN-PC. All rights reserved.
//

#import "ViewController.h"
#import "imageDownloadingViewController.h"
#import "delegateViewController.h"
@interface ViewController ()<delegateBy>

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)awakeFromNib
{
    }
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"karthi"]) {
        self.array=[[NSUserDefaults standardUserDefaults]valueForKey:@"karthi"];
    }else
    {
        self.array=[[NSMutableArray alloc]initWithObjects:@"karthi",@"angu", nil];

    }
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style: UIBarButtonItemStyleBordered target:self action:@selector(addORDeleteRows)];[self.navigationItem setLeftBarButtonItem:addButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Image"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu)];

    // Do any additional setup after loading the view from its nib.
}
-(void)showMenu
{
    [[self navigationController]pushViewController:[[imageDownloadingViewController alloc]init] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addORDeleteRows
{
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView  reloadData];
//     [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView  setEditing:YES animated:YES];
        [self.tableView  reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}
#pragma tableview\\\\\\




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.array count];
    if(self.editing) count++;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.editingAccessoryType = YES;
    }
    int count = 0;
    if(self.editing && indexPath.row != 0)
        count = 1;
    
    if(indexPath.row == ([self.array count]) && self.editing){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PlainTextStyle"
//                                                            message:@"Enter plain text"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"Cancel"
//                                                  otherButtonTitles:@"OK", nil];
//        
//        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
//        [alertView show];

        cell.textLabel.text = @"Append a new row";
        return cell;
    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing == NO || !indexPath)
        return UITableViewCellEditingStyleNone;
    
    if (self.editing && indexPath.row == ([self.array count]))
        return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
    
    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.array removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        [self.array insertObject:@"New version" atIndex:[self.array count]];
        [self.tableView reloadData];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    delegateViewController *objDelegate=[[delegateViewController alloc]init];
    objDelegate.delegate=self;
    objDelegate.string=[self.array objectAtIndex:indexPath.row];
    objDelegate.index=indexPath.row;
    
    [[self navigationController]pushViewController:objDelegate animated:YES];
}
-(void)selectedName:(NSString *)name index:(NSString *)index
{
    [self.array replaceObjectAtIndex:[index integerValue]  withObject:name];
    [[NSUserDefaults standardUserDefaults] setObject:self.array  forKey:@"karthi"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    NSLog(@"%@ %@", index ,name);
    

}
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"Alert View dismissed with button at index %d",buttonIndex);
//    
//    switch (alertView.alertViewStyle)
//    {
//        case UIAlertViewStylePlainTextInput:
//        {
//            UITextField *textField = [alertView textFieldAtIndex:0];
//            NSLog(@"Plain text input: %@",textField.text);
//        }
//            break;
//            
//                default:
//            break;
//    }
//}
//
//- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
//{
//    UIAlertViewStyle style = alertView.alertViewStyle;
//    
//    if ((style == UIAlertViewStyleSecureTextInput) ||
//        (style == UIAlertViewStylePlainTextInput) ||
//        (style == UIAlertViewStyleLoginAndPasswordInput))
//    {
//        UITextField *textField = [alertView textFieldAtIndex:0];
//        if ([textField.text length] == 0)
//        {
//            return NO;
//        }
//    }
//    
//    return YES;
//}
//
@end
