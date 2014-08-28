//
//  GlobalFunctions.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/22.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "GlobalFunctions.h"

#import <objc/runtime.h>

@implementation UIView (GlobalFunctions)

- (UIImage *)convertToImage
{
	UIImage *returnimage;
	UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width, self.frame.size.height));
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[self.layer renderInContext:ctx];
	returnimage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return returnimage;
}

- (UIView *)findFirstResponder
{
	if (self.isFirstResponder) return self;
	for (UIView *subView in self.subviews) {
		UIView *firstResponder = [subView findFirstResponder];
		if (firstResponder != nil) return firstResponder;
	}
	return nil;
}

@end

@implementation UISearchBar (GlobalFunctions)

- (RACSignal *)rac_textSignal
{
	self.delegate = (id <UISearchBarDelegate> )self;
	RACSignal *signal = objc_getAssociatedObject(self, _cmd);
	if (signal != nil) return signal;
	signal = [[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)] map: ^id (RACTuple *tuple) {
	    return tuple.second;
	}];
	objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	return signal;
}

@end

