//
//  RealmInterface.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealmInterface : NSObject

+(void) addNewContactToDB : (NSString*) firstNameString
             withLastName : (NSString*) lastNameString
              withCompany : (NSString*) companyString
               withAvatar : (NSData*) avatarImageData
          withPhoneNumber : (NSString*) phoneNumberString
              withAddress : (NSString*) addressString
                 withNote : (NSString*) noteString;

@end
