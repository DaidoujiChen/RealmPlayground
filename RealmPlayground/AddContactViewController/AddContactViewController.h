//
//  AddContactViewController.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *companyTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *addressTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
