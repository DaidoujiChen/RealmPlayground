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

#pragma mark - life cycle

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setTitle:@"AddressBook"];
    [self.mainTableView registerClass:[MainCell class] forCellReuseIdentifier:@"MainCell"];
    
    [self setupNavigationRightButton];
    
}

@end
