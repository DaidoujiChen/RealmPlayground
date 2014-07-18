//
//  EditContactViewController.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()

@end

@implementation EditContactViewController

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private

-(void) setupSubmitButton {
    
    RAC(self.submitButton, enabled) = [RACSignal combineLatest:@[self.firstNameTextField.rac_textSignal, self.lastNameTextField.rac_textSignal] reduce:^id(NSString *firstName, NSString *lastName){
        
        if (firstName.length && lastName.length) {
            return @YES;
        } else {
            return @NO;
        }
        
    }];
    
    [[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *btn) {
        
        [RealmInterface editContactData:self.editAddressBook
                             withFirstName:self.firstNameTextField.text
                              withLastName:self.lastNameTextField.text
                               withCompany:self.companyTextField.text
                                withAvatar:(self.avatarImageView.image?UIImageJPEGRepresentation(self.avatarImageView.image, 1.0f):nil)
                           withPhoneNumber:self.phoneNumberTextField.text
                               withAddress:self.addressTextField.text
                                  withNote:self.noteTextField.text];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

-(void) setupExistData {
    
    self.avatarImageView.image = [UIImage imageWithData:self.editAddressBook.avatarImageData];
    self.firstNameTextField.text = self.editAddressBook.firstNameString;
    self.lastNameTextField.text = self.editAddressBook.lastNameString;
    self.companyTextField.text = self.editAddressBook.companyString;
    self.phoneNumberTextField.text = self.editAddressBook.phoneNumberString;
    self.addressTextField.text = self.editAddressBook.addressString;
    self.noteTextField.text = self.editAddressBook.noteString;
    
}

#pragma mark - life cycle

-(void) viewDidLoad {
    
    [self setupExistData];
    
    [super viewDidLoad];
    
    [self setTitle:@"Edit"];
    [self.submitButton setTitle:@"Update" forState:UIControlStateNormal];
    [self.submitButton setEnabled:YES];
    
    
    
}

@end
