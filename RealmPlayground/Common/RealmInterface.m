//
//  RealmInterface.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "RealmInterface.h"

@implementation RLMObject (Edit)

- (void)editContact:(AddressBook *(^)(AddressBook *addressbook))AddressBookBlock
{
	[[RLMRealm defaultRealm] beginWriteTransaction];
	AddressBookBlock((AddressBook *)self);
	[[RLMRealm defaultRealm] commitWriteTransaction];
}

@end

@implementation RealmInterface

#pragma mark - class method

+ (void)addNewContact:(AddressBook *(^)(AddressBook *addressbook))AddressBookBlock
{
	AddressBook *newAddressBook = [AddressBook new];
	[[RLMRealm defaultRealm] beginWriteTransaction];
	[[RLMRealm defaultRealm] addObject:AddressBookBlock(newAddressBook)];
	[[RLMRealm defaultRealm] commitWriteTransaction];
}

+ (void)exchangeContactFomrIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
	AddressBook *fromObject = [[AddressBook allObjects] objectAtIndex:fromIndex];
	AddressBook *toObject = [[AddressBook allObjects] objectAtIndex:toIndex];
	[[RLMRealm defaultRealm] beginWriteTransaction];
	for (RLMProperty *prop in fromObject.objectSchema.properties) {
		id swapObject = fromObject[prop.name];
		fromObject[prop.name] = toObject[prop.name];
		toObject[prop.name] = swapObject;
	}
	[[RLMRealm defaultRealm] commitWriteTransaction];
}

+ (RLMArray *)dataSourceFilter:(NSString *)filterString
{
	if (filterString) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstNameString contains[c] %@", filterString];
		return [AddressBook objectsWithPredicate:predicate];
	} else {
		return [AddressBook allObjects];
	}
}

+ (void)deleteObject:(id)anObject
{
	[[RLMRealm defaultRealm] beginWriteTransaction];
	[[RLMRealm defaultRealm] deleteObject:anObject];
	[[RLMRealm defaultRealm] commitWriteTransaction];
}

#pragma mark - private

+ (RLMArray *)dataSource
{
	return [AddressBook allObjects];
}

@end
