//
//  DropdownContentTableViewCell.h
//  PPDropDownMenu
//
//  Created by Zhipeng on 15/3/2016.
//  Copyright © 2016 Zhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownContentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *buttonNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *selectIndicator;
@property (assign, nonatomic) BOOL isCellSelected;

@end
