//
//  AddContactViewController+Components.m
//  RealmPlayground
//
//  Created by 啟倫 陳 on 2014/7/18.
//  Copyright (c) 2014年 ChilunChen. All rights reserved.
//

#import "AddContactViewController+Components.h"

@implementation AddContactViewController (Components)

#pragma mark - private

- (void)nextTextField
{
	NSUInteger currentIndex = [[self textFields] indexOfObject:[self.view findFirstResponder]];
	NSUInteger nextIndex = currentIndex + 1;
	nextIndex += [[self textFields] count];
	nextIndex %= [[self textFields] count];
	UITextField *nextTextField = [[self textFields] objectAtIndex:nextIndex];
	[nextTextField becomeFirstResponder];
}

- (void)prevTextField
{
	NSUInteger currentIndex = [[self textFields] indexOfObject:[self.view findFirstResponder]];
	NSUInteger prevIndex = currentIndex - 1;
	prevIndex += [[self textFields] count];
	prevIndex %= [[self textFields] count];
	UITextField *nextTextField = [[self textFields] objectAtIndex:prevIndex];
	[nextTextField becomeFirstResponder];
}

- (void)textFieldDone
{
	[[self.view findFirstResponder] resignFirstResponder];
}

- (NSArray *)textFields
{
	NSMutableArray *returnArray = [NSMutableArray array];
	for (UIView *eachView in self.view.subviews) {
		if ([eachView isKindOfClass:[JVFloatLabeledTextField class]]) {
			[returnArray addObject:eachView];
		}
	}
	return returnArray;
}

#pragma mark - instance method

- (UIToolbar *)createToolbar
{
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
	UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textFieldDone)];
	toolBar.items = @[prevButton, nextButton, space, done];
	return toolBar;
}

@end
