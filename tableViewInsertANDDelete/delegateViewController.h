//
//  delegateViewController.h
//  tableViewInsertANDDelete
//
//  Created by Subramani B R on 3/26/14.
//  Copyright (c) 2014 JAYAMURUGAN-PC. All rights reserved.
//
@protocol delegateBy <NSObject>

-(void)selectedName:(NSString *)name index:(NSString *)index;

@end
#import <UIKit/UIKit.h>

@interface delegateViewController : UIViewController
{
    UITextField *textField;
    UIButton *buttonAction;
    
}
@property(nonatomic,strong)id<delegateBy> delegate;

@property(nonatomic,strong)NSString *string;
@property(nonatomic,assign)int *index;

@end
