//
//  GlobalFunctions.h
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/22.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (GlobalFunctions)

-(UIImage*) convertToImage;
-(UIView*) findFirstResponder;

@end

@interface UISearchBar (GlobalFunctions)

-(RACSignal*) rac_textSignal;

@end

@interface GlobalFunctions : NSObject
@end
