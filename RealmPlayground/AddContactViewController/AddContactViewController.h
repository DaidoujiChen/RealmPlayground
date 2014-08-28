//
//  AddContactViewController.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *firstNameTextField;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *lastNameTextField;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *companyTextField;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *phoneNumberTextField;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *addressTextField;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *noteTextField;
@property (nonatomic, weak) IBOutlet UIButton *submitButton;

@end
