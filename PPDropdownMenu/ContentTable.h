//
//  ContentTable.h
//  PPDropDownMenu
//
//  Created by zhipeng on 16/3/14.
//  Copyright © 2016年 Zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol DropdownContentTableDelegate <NSObject>
- (void) contentTabledidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ContentTable : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray* dropdownContentList;
@property (nonatomic, strong)NSMutableDictionary* dropdownContentDict;
@property (nonatomic, strong)NSMutableArray* cellSelectedList;
@property (nonatomic, strong)NSMutableDictionary* cellSelectedDict;
@property (nonatomic, assign)BOOL canDuplicateSelect;
@property (nonatomic, assign)id <DropdownContentTableDelegate>delegate;
@end
