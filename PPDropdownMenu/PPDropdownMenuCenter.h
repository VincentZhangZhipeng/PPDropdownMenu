//
//  PPDropdownMenuCenter.h
//  PPDropDownMenu
//
//  Created by Zhipeng on 15/3/2016.
//  Copyright © 2016 Zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DropdownContentTable.h"
#import "ContentTable.h"
#import "PPDropdownButton.h"

@protocol DropdownButtonDelegate <NSObject>
- (void)dropdownButtonDidClick:(UIButton*)button;
- (void)dropdownContentTableDidSelected:(NSIndexPath*) indexPath;

@end

@interface PPDropdownMenuCenter : NSObject<DropdownContentTableDelegate>
@property (assign, nonatomic) id<DropdownButtonDelegate> dropDownButtonDelegate;
@property (strong, nonatomic) PPDropdownButton* dropdownButton;
@property (strong, nonatomic) DropdownContentTable* contentTable;
@property (nonatomic, strong) ContentTable* contentTableDelegate;
@property (nonatomic, strong) UIView* blockView;
@property (nonatomic, assign) BOOL showContentTableView;
@property (nonatomic, assign) CGRect contentFrame;

- (void)setUpWithMainViewController:(UIViewController*) mainViewController DropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentFrame andContentTableNameList: (NSArray*)contentTableNameList;

- (void)setUpWithMainViewController:(UIViewController*) mainViewController DropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentFrame andContentTableNameDict: (NSMutableDictionary*)contentTableDict;

- (void)setDropdownButtonTitle:(NSString*)title;
- (void)setDropdownButtonBackgroundColor:(UIColor*)color;

@end
