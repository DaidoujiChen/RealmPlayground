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

- (void)setupTextFields;
- (void)setupSubmitButton;

@end

@implementation AddContactViewController

#pragma mark - ibaction

- (IBAction)addImageAction:(id)sender
{
	UIImagePickerController *imagePickerController = [UIImagePickerController new];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
	[self presentViewController:imagePickerController animated:YES completion: ^{
	}];
}

#pragma mark - private

- (void)setupTextFields
{
	UIToolbar *toolBar = [self createToolbar];
	for (UIView *eachView in self.view.subviews) {
		if ([eachView isKindOfClass:[JVFloatLabeledTextField class]]) {
			JVFloatLabeledTextField *textField = (JVFloatLabeledTextField *)eachView;
			textField.delegate = self;
			textField.font = [UIFont systemFontOfSize:18.0f];
			textField.floatingLabel.font = [UIFont boldSystemFontOfSize:14.0f];
			textField.floatingLabelTextColor = [UIColor grayColor];
			textField.inputAccessoryView = toolBar;
		}
	}
}

- (void)setupSubmitButton
{
	RACSignal *firstNameSignal = [RACSignal merge:@[self.firstNameTextField.rac_textSignal, RACObserve(self.firstNameTextField, text)]];
	RACSignal *lastNameSignal = [RACSignal merge:@[self.lastNameTextField.rac_textSignal, RACObserve(self.lastNameTextField, text)]];
	RAC(self.submitButton, enabled) = [RACSignal combineLatest:@[firstNameSignal, lastNameSignal] reduce: ^id (NSString *firstName, NSString *lastName) {
	    if (firstName.length && lastName.length) {
	        return @YES;
		} else {
	        return @NO;
		}
	}];

	@weakify(self);
	[[self.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext: ^(UIButton *btn) {
	    @strongify(self);
	    [RealmInterface addNewContact: ^AddressBook *(AddressBook *addressbook) {
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

#pragma mark - life cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.title = @"Add";
	[self setupTextFields];
	[self setupSubmitButton];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

@end
