//
//  AddressBook.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <Realm/Realm.h>

@interface AddressBook : RLMObject

@property NSString *firstNameString;
@property NSString *lastNameString;
@property NSString *companyString;
@property NSData *avatarImageData;
@property NSString *phoneNumberString;
@property NSString *addressString;
@property NSString *noteString;

@end

RLM_ARRAY_TYPE(AddressBook)
