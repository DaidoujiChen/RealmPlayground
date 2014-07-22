//
//  MainViewController.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private

-(void) addContact {
    
    [self.navigationController pushViewController:[AddContactViewController new] animated:YES];
    
}

-(void) setupNavigationRightButton {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void) setupMainSearchBar {
    
    [[self.mainSearchBar rac_textSignal] subscribeNext:^(NSString* text) {
        
        self.searchFilterString = text;
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabScreenAction)];
        [self.view addGestureRecognizer:tapGesture];
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(id x) {
        
        for (UIGestureRecognizer *eachGesture in self.view.gestureRecognizers) {
            [self.view removeGestureRecognizer:eachGesture];
        }
        
    }];
    
    [RACObserve(self, searchFilterString) subscribeNext:^(id x) {
        
        [self.mainTableView reloadData];
        
    }];
    
}


-(void) tabScreenAction {
    
    if ([self.mainSearchBar isFirstResponder]) {
        [self.mainSearchBar resignFirstResponder];
    }
    
}

#pragma mark - life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setTitle:@"AddressBook"];
    [self.mainTableView registerClass:[MainCell class] forCellReuseIdentifier:@"MainCell"];
    
    [self setupNavigationRightButton];
    [self setupMainSearchBar];
    
}

-(void) viewWillAppear : (BOOL) animated {
    [super viewWillAppear:animated];
    
    [self.mainTableView reloadData];
}

@end
