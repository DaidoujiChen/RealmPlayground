//
//  MainViewController.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "MainViewController.h"

#import <objc/runtime.h>

@implementation UISearchBar (RAC)

-(RACSignal*) rac_textSignal {
    
    self.delegate = (id<UISearchBarDelegate>)self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    
    if (signal != nil) return signal;
    
    signal = [[self rac_signalForSelector:@selector(searchBar:textDidChange:)
                             fromProtocol:@protocol(UISearchBarDelegate)] map:^id(RACTuple *tuple) {
        return tuple.second;
    }];
    
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
    
}

@end

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
    
    [RACObserve(self, searchFilterString) subscribeNext:^(id x) {
        
        [self.mainTableView reloadData];
        
    }];
    
}

#pragma mark - ibaction

-(IBAction) tabScreenAction : (id) sender {
    
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
