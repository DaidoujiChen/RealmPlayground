//
//  MainViewController+TableViewHandler.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "MainViewController+TableViewHandler.h"

@implementation MainViewController (TableViewHandler)

#pragma mark - UITableViewDataSource

-(NSInteger) tableView : (UITableView*) tableView numberOfRowsInSection : (NSInteger) section {
    
    return [[RealmInterface dataSource] count];
    
}

-(UITableViewCell*) tableView : (UITableView*) tableView cellForRowAtIndexPath : (NSIndexPath*) indexPath {
    
    AddressBook *eachData = [[RealmInterface dataSource] objectAtIndex:indexPath.row];
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = eachData.companyString;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", eachData.firstNameString, eachData.lastNameString];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18.0f];
    
    cell.imageView.image = [UIImage imageWithData:eachData.avatarImageData];
    
    return cell;
    
}

@end
