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

#pragma mark - private

- (void)setupSubmitButton
{
	RAC(self.submitButton, enabled) = [RACSignal combineLatest:@[self.firstNameTextField.rac_textSignal, self.lastNameTextField.rac_textSignal] reduce: ^id (NSString *firstName, NSString *lastName) {
	    if (firstName.length && lastName.length) {
	        return @YES;
		} else {
	        return @NO;
		}
	}];

    @weakify(self);
	[[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext: ^(UIButton *btn) {
	    [self.editAddressBook editContact: ^AddressBook *(AddressBook *addressbook) {
            @strongify(self);
	        addressbook.firstNameString = self.firstNameTextField.text;
	        addressbook.lastNameString = self.lastNameTextField.text;
	        addressbook.companyString = self.companyTextField.text;
	        if (self.avatarImageView.image) {
	            addressbook.avatarImageData = UIImageJPEGRepresentation(self.avatarImageView.image, 1.0f);
			} else {
	            UIImageView *blackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
                blackImageView.backgroundColor = [UIColor blackColor];
	            addressbook.avatarImageData = UIImageJPEGRepresentation([blackImageView convertToImage], 1.0f);
			}
	        addressbook.phoneNumberString = self.phoneNumberTextField.text;
	        addressbook.addressString = self.addressTextField.text;
	        addressbook.noteString = self.noteTextField.text;
	        return addressbook;
		}];

	    [self.navigationController popViewControllerAnimated:YES];
	}];
}

- (void)setupExistData
{
	self.avatarImageView.image = [UIImage imageWithData:self.editAddressBook.avatarImageData];
	self.firstNameTextField.text = self.editAddressBook.firstNameString;
	self.lastNameTextField.text = self.editAddressBook.lastNameString;
	self.companyTextField.text = self.editAddressBook.companyString;
	self.phoneNumberTextField.text = self.editAddressBook.phoneNumberString;
	self.addressTextField.text = self.editAddressBook.addressString;
	self.noteTextField.text = self.editAddressBook.noteString;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupExistData];
    self.title = @"Edit";
	[self.submitButton setTitle:@"Update" forState:UIControlStateNormal];
    self.submitButton.enabled = YES;
}

@end
