//
//  MainViewController.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

- (void)addContact;
- (void)editeditContact;
- (void)setupNavigationRightButton;
- (void)setupMainSearchBar;
- (void)tabScreenAction;

@end

@implementation MainViewController

#pragma mark - private

- (void)addContact
{
	[self.navigationController pushViewController:[AddContactViewController new] animated:YES];
}

- (void)editeditContact
{
	self.mainTableView.editing = !self.mainTableView.editing;
}

- (void)setupNavigationRightButton
{
	UIBarButtonItem *addContactItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
	UIBarButtonItem *editContactItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editeditContact)];
	self.navigationItem.rightBarButtonItems = @[addContactItem, editContactItem];
}

- (void)setupMainSearchBar
{
	[[self.mainSearchBar rac_textSignal] subscribeNext: ^(NSString *text) {
	    self.searchFilterString = text;
	}];

    __block UITapGestureRecognizer *tapGesture;
    @weakify(self);
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext: ^(id x) {
        @strongify(self);
	    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabScreenAction)];
	    [self.view addGestureRecognizer:tapGesture];
	}];

	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext: ^(id x) {
        @strongify(self);
        [self.view removeGestureRecognizer:tapGesture];
	}];

	[RACObserve(self, searchFilterString) subscribeNext: ^(id x) {
        @strongify(self);
	    [self.mainTableView reloadData];
	}];
}

- (void)tabScreenAction
{
	if ([self.mainSearchBar isFirstResponder]) {
		[self.mainSearchBar resignFirstResponder];
	}
}

#pragma mark - life cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"AddressBook";
	[self.mainTableView registerClass:[MainCell class] forCellReuseIdentifier:@"MainCell"];
	[self setupNavigationRightButton];
	[self setupMainSearchBar];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.mainTableView reloadData];
}

@end
