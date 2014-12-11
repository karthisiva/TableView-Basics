//
//  ViewController.h
//  tableViewInsertANDDelete
//
//  Created by JAYAMURUGAN-PC on 2/5/14.
//  Copyright (c) 2014 JAYAMURUGAN-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *array;

@end
