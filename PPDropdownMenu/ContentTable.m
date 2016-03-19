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
    if (self.dropdownContentList) {
        return 1;
    
    }else if(self.dropdownContentDict){
        return [self.dropdownContentDict count];
    
    }
        
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.dropdownContentList) {
        return [self.dropdownContentList count];
    
    }else if(self.dropdownContentDict){
        return [[self.dropdownContentDict objectForKey:[NSNumber numberWithInteger:section]] count];
    
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DropdownContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = (DropdownContentTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"DropdownContentTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    }
    // Configure the cell...
    if (self.dropdownContentDict) {
        NSArray* dropdownContentList = [self.dropdownContentDict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
        cell.buttonNameLabel.text = [dropdownContentList objectAtIndex:indexPath.row];
        
        NSArray* cellSelectedList = [self.cellSelectedDict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
        BOOL isCellSelected = [[cellSelectedList objectAtIndex: indexPath.row] boolValue];
        cell.selectIndicator.hidden = !isCellSelected;
        
    }else if(self.dropdownContentList){
        cell.buttonNameLabel.text = [self.dropdownContentList objectAtIndex:indexPath.row];
        BOOL isCellSelected = [[self.cellSelectedList objectAtIndex: indexPath.row] boolValue];
        cell.selectIndicator.hidden = !isCellSelected;
    
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dropdownContentDict) {
        if (!self.canDuplicateSelect) {
            for (NSString* key in self.cellSelectedDict) {
                NSMutableArray* cellSelectedList = [self.cellSelectedDict objectForKey:key];
                
                for(NSInteger index = 0; index < [cellSelectedList count]; index++){
                    [cellSelectedList replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
                }
                
            }
            
            for(NSIndexPath*index in tableView.indexPathsForVisibleRows){
                DropdownContentTableViewCell* cell = [tableView cellForRowAtIndexPath:index];
                cell.selectIndicator.hidden = YES;
                
            }
        }

        
        DropdownContentTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectIndicator.hidden = NO;
        
        NSMutableArray* cellSelectedList = [self.cellSelectedDict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
        [cellSelectedList replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        
    
    }else if(self.dropdownContentList){
        
        if (!self.canDuplicateSelect) {
            for(NSIndexPath*index in tableView.indexPathsForVisibleRows){
                DropdownContentTableViewCell* cell = [tableView cellForRowAtIndexPath:index];
                cell.selectIndicator.hidden = YES;
                
            }
            
            for(NSInteger index = 0; index < [self.cellSelectedList count]; index++){
                [self.cellSelectedList replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
                
            }
            
        }
        
        DropdownContentTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectIndicator.hidden = NO;
        
        [self.cellSelectedList replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];

    
    }
    
    
    
    [self.delegate contentTabledidSelectRowAtIndexPath:indexPath fromDelegate:self.delegate];
    
//    tableView.hidden = YES;
}

@end
