//
//  ContentTable.m
//  PPDropDownMenu
//
//  Created by zhipeng on 16/3/14.
//  Copyright © 2016年 Zhipeng. All rights reserved.
//

#import "ContentTable.h"
#import "DropdownContentTableViewCell.h"

@implementation ContentTable
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dropdownContentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DropdownContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = (DropdownContentTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"DropdownContentTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    }
    // Configure the cell...
    cell.buttonNameLabel.text = [self.dropdownContentList objectAtIndex:indexPath.row];
    BOOL isCellSelected = [[self.cellSelectedList objectAtIndex: indexPath.row] boolValue];
    cell.selectIndicator.hidden = !isCellSelected;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(NSIndexPath*index in tableView.indexPathsForVisibleRows){
        DropdownContentTableViewCell* cell = [tableView cellForRowAtIndexPath:index];
        cell.selectIndicator.hidden = YES;

}
    if (!self.canDuplicateSelect) {
        for(NSInteger index = 0; index < [self.cellSelectedList count]; index++){
            [self.cellSelectedList replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
        
        }
        
    }
    
    DropdownContentTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectIndicator.hidden = NO;
    
     [self.cellSelectedList replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    
    
    [self.delegate contentTabledidSelectRowAtIndexPath:indexPath];
    
//    tableView.hidden = YES;
}

@end
