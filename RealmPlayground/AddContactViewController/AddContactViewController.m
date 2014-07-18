//
//  AddContactViewController.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "AddContactViewController.h"

#import "AddContactViewController+UIImagePickerHandler.h"
#import "AddContactViewController+TextFieldHandler.h"
#import "AddContactViewController+Components.h"

@interface AddContactViewController ()
@end

@implementation AddContactViewController

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ibaction

-(IBAction) addImageAction : (id) sender {
    
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:^{
    }];
    
}

#pragma mark - private

-(void) setupTextFields {
    
    UIToolbar *toolBar = [self createToolbar];
    
    for (UIView *eachView in self.view.subviews) {
        
        if ([eachView isKindOfClass:[JVFloatLabeledTextField class]]) {
            
            JVFloatLabeledTextField *textField = (JVFloatLabeledTextField*)eachView;
            
            textField.delegate = self;
            
            textField.font = [UIFont systemFontOfSize:18.0f];
            textField.floatingLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            textField.floatingLabelTextColor = [UIColor grayColor];
            
            textField.inputAccessoryView = toolBar;
            
        }
        
    }
    
}

-(void) setupSubmitButton {
    
    RAC(self.submitButton, enabled) = [RACSignal combineLatest:@[self.firstNameTextField.rac_textSignal, self.lastNameTextField.rac_textSignal] reduce:^id(NSString *firstName, NSString *lastName){
        
        if (firstName.length && lastName.length) {
            return @YES;
        } else {
            return @NO;
        }
        
    }];
    
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        
        [RealmInterface addNewContactToDB:self.firstNameTextField.text
                             withLastName:self.lastNameTextField.text
                              withCompany:self.companyTextField.text
                               withAvatar:(self.avatarImageView.image?UIImageJPEGRepresentation(self.avatarImageView.image, 1.0f):nil)
                          withPhoneNumber:self.phoneNumberTextField.text
                              withAddress:self.addressTextField.text
                                 withNote:self.noteTextField.text];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

#pragma mark - life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self setupTextFields];
    [self setupSubmitButton];
    
}

-(void) viewWillAppear : (BOOL) animated {
    [super viewWillAppear:animated];
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    
}


-(void) viewWillDisappear : (BOOL) animated {
    [super viewWillDisappear:animated];
    
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
    
}

@end
