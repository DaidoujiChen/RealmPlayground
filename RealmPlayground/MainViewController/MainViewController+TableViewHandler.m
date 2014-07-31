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
    
    return [[RealmInterface dataSourceFilter:self.searchFilterString] count];
    
}

-(UITableViewCell*) tableView : (UITableView*) tableView cellForRowAtIndexPath : (NSIndexPath*) indexPath {
    
    AddressBook *eachData = [[RealmInterface dataSourceFilter:self.searchFilterString] objectAtIndex:indexPath.row];
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = eachData.companyString;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", eachData.firstNameString, eachData.lastNameString];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18.0f];
    
    cell.imageView.image = [UIImage imageWithData:eachData.avatarImageData];
    
    return cell;
    
}

-(void) tableView : (UITableView*) tableView commitEditingStyle : (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath : (NSIndexPath*) indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        AddressBook *deleteData = [[RealmInterface dataSourceFilter:self.searchFilterString] objectAtIndex:indexPath.row];
        [RealmInterface deleteObject:deleteData];
        [tableView reloadData];
        
    }
    
}

-(BOOL) tableView : (UITableView*) tableView canEditRowAtIndexPath : (NSIndexPath*) indexPath {
    
    return YES;
    
}

-(void) tableView : (UITableView*) tableView moveRowAtIndexPath : (NSIndexPath*) sourceIndexPath toIndexPath : (NSIndexPath*) destinationIndexPath {
    
    [RealmInterface exchangeContactFomrIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
    [tableView reloadData];
    
}


#pragma mark - UITableViewDelegate

-(void) tableView : (UITableView*) tableView didSelectRowAtIndexPath : (NSIndexPath*) indexPath {

    EditContactViewController *editViewController = [[EditContactViewController alloc] initWithNibName:@"AddContactViewController" bundle:nil];
    editViewController.editAddressBook = [[RealmInterface dataSourceFilter:self.searchFilterString] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editViewController animated:YES];
    
}


@end
