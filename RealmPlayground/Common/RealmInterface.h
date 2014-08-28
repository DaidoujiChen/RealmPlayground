//
//  RealmInterface.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AddressBook.h"

@interface RLMObject (Edit)

- (void)editContact:(AddressBook *(^)(AddressBook *addressbook))AddressBookBlock;

@end


@interface RealmInterface : NSObject

+ (void)addNewContact:(AddressBook *(^)(AddressBook *addressbook))AddressBookBlock;
+ (void)exchangeContactFomrIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
+ (RLMArray *)dataSourceFilter:(NSString *)filterString;
+ (void)deleteObject:(id)anObject;

@end
