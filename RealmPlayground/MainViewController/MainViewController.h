//
//  MainViewController.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddContactViewController.h"
#import "EditContactViewController.h"
#import "MainCell.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) NSString *searchFilterString;

@property (nonatomic, weak) IBOutlet UITableView *mainTableView;
@property (nonatomic, weak) IBOutlet UISearchBar *mainSearchBar;

@end
