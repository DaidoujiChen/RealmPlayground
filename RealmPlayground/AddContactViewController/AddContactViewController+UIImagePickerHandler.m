//
//  AddContactViewController+UIImagePickerHandler.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "AddContactViewController+UIImagePickerHandler.h"

@implementation AddContactViewController (UIImagePickerHandler)

-(void) imagePickerController : (UIImagePickerController*) picker didFinishPickingMediaWithInfo : (NSDictionary*) info {
    
    self.avatarImageView.image = info[@"UIImagePickerControllerEditedImage"];
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

-(void) imagePickerControllerDidCancel : (UIImagePickerController*) picker {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

@end
