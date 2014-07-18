//
//  RealmInterface.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "RealmInterface.h"

#define createNewData AddressBook *addressBook = [AddressBook new];
#define addProperty(arg) addressBook.arg = arg;

@implementation UIView (ConvertToImage)

-(UIImage*) convertToImage {
    
    UIImage *returnimage;
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width,self.frame.size.height));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    returnimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnimage;
    
}

@end

@implementation RealmInterface

#pragma mark - class method

+(void) addNewContact : (NSString*) firstNameString
             withLastName : (NSString*) lastNameString
              withCompany : (NSString*) companyString
               withAvatar : (NSData*) avatarImageData
          withPhoneNumber : (NSString*) phoneNumberString
              withAddress : (NSString*) addressString
                 withNote : (NSString*) noteString {
    
    createNewData
    addProperty(firstNameString)
    addProperty(lastNameString)
    addProperty(companyString)
    
    if (avatarImageData) {
        addProperty(avatarImageData)
    } else {
        
        UIImageView *blackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [blackImageView setBackgroundColor:[UIColor blackColor]];
        addressBook.avatarImageData = UIImageJPEGRepresentation([blackImageView convertToImage], 1.0f);
        
    }
    
    addProperty(phoneNumberString)
    addProperty(addressString)
    addProperty(noteString)
    
    addressBook.createDate = [NSDate date];
    
    [[self realm] beginWriteTransaction];
    [[self realm] addObject:addressBook];
    [[self realm] commitWriteTransaction];
    
}

+(void) editContactData : (AddressBook*) addressBook
          withFirstName : (NSString*) firstNameString
           withLastName : (NSString*) lastNameString
            withCompany : (NSString*) companyString
             withAvatar : (NSData*) avatarImageData
        withPhoneNumber : (NSString*) phoneNumberString
            withAddress : (NSString*) addressString
                withNote : (NSString*) noteString {
    
    [[self realm] beginWriteTransaction];
    
    addProperty(firstNameString)
    addProperty(lastNameString)
    addProperty(companyString)
    
    if (avatarImageData) {
        addProperty(avatarImageData)
    } else {
        
        UIImageView *blackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [blackImageView setBackgroundColor:[UIColor blackColor]];
        addressBook.avatarImageData = UIImageJPEGRepresentation([blackImageView convertToImage], 1.0f);
        
    }
    
    addProperty(phoneNumberString)
    addProperty(addressString)
    addProperty(noteString)

    [[self realm] commitWriteTransaction];
    
}

+(RLMArray*) dataSourceFilter : (NSString*) filterString {
    
    if (filterString) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstNameString contains[c] %@", filterString];
        return [AddressBook objectsWithPredicate:predicate];
        
    } else {
        return [AddressBook allObjects];
    }
    
}

+(void) deleteObject : (id) anObject {
    
    [[self realm] beginWriteTransaction];
    [[self realm] deleteObject:anObject];
    [[self realm] commitWriteTransaction];
    
}

#pragma mark - private

+(RLMRealm*) realm {
    
    static RLMRealm *returnRealm;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        returnRealm = [RLMRealm defaultRealm];
    });
    return returnRealm;
    
}

+(RLMArray*) dataSource {
    
    return [AddressBook allObjects];
    
}

@end
