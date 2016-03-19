//
//  PPDropdownMenuCenter.m
//  PPDropDownMenu
//
//  Created by Zhipeng on 15/3/2016.
//  Copyright © 2016 Zhipeng. All rights reserved.
//

#import "PPDropdownMenuCenter.h"

@implementation PPDropdownMenuCenter

-(void)setUpWithDropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentFrame{
    self.dropdownButton = [[PPDropdownButton alloc] initWithFrame:buttonFrame];
    self.contentTable = [[DropdownContentTable alloc] initWithFrame:contentFrame];
    self.contentFrame = contentFrame;
   
    [self.dropdownButton addTarget:self
             action:@selector(dropdownButtonClicked) forControlEvents:UIControlEventTouchUpInside];


}

- (void)setUpWithMainViewController:(UIViewController*) mainViewController DropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentFrame andContentTableNameList: (NSArray*)contentTableNameList{
    
    [self setUpWithDropdownButtonFrame:buttonFrame ContentTableView:contentFrame];
    
    self.contentTableDelegate = [[ContentTable alloc] init];
    self.contentTableDelegate.delegate = self;
    self.contentTableDelegate.dropdownContentList = contentTableNameList;
    NSMutableArray* selectedList = [NSMutableArray array];
    for(NSInteger i = 0; i< [contentTableNameList count]; i++){
        [selectedList addObject:[NSNumber numberWithBool:NO]];
    
    }
    [selectedList replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:YES]];
    
    self.contentTableDelegate.cellSelectedList = selectedList;
    
    [self.contentTable setDelegate:self.contentTableDelegate];
    [self.contentTable setDataSource:self.contentTableDelegate];
    self.contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dropdownButton.backgroundColor = [UIColor orangeColor];
    self.dropDownButtonDelegate = mainViewController;
    [mainViewController.view addSubview:self.dropdownButton];
    [mainViewController.view addSubview:self.contentTable];
    [mainViewController.view bringSubviewToFront:self.contentTable];
    
    CGFloat blockViewY = self.contentTable.frame.origin.y + self.contentTable.frame.size.height;
    self.blockView = [[UIView alloc] initWithFrame: CGRectMake(0, blockViewY, mainViewController.view.frame.size.width, mainViewController.view.frame.size.height - blockViewY)];
    self.blockView.hidden = YES;
    self.blockView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBlockView)];
    
    [self.blockView addGestureRecognizer:singleFingerTap];
    [mainViewController.view addSubview:self.blockView];
    [mainViewController.view bringSubviewToFront:self.blockView];
    
    self.contentTable.frame = CGRectMake(self.contentTable.frame.origin.x, self.contentTable.frame.origin.y, self.contentTable.frame.size.width, 0);
    
    
}

- (void)setUpWithMainViewController:(UIViewController*) mainViewController DropdownButtonFrame:(CGRect)buttonFrame ContentTableView:(CGRect)contentFrame andContentTableNameDict: (NSMutableDictionary*)contentTableDict{
    [self setUpWithDropdownButtonFrame:buttonFrame ContentTableView:contentFrame];
    
    self.contentTableDelegate = [[ContentTable alloc] init];
    self.contentTableDelegate.delegate = self;
    self.contentTableDelegate.dropdownContentDict = contentTableDict;
    
    NSMutableDictionary* selectedDict = [[NSMutableDictionary alloc]init];
    NSInteger count = 0;
    for(NSString* key in contentTableDict){
        NSMutableArray* selectedList = [[NSMutableArray alloc] init];
        for(NSInteger i = 0; i<  [[contentTableDict objectForKey:key] count]; i++){
            [selectedList addObject: [NSNumber numberWithBool:NO]];
            
        }


        [selectedDict setObject:selectedList forKey:[NSNumber numberWithInteger:count]];
        count ++;

    }
    
    NSMutableArray* selectedList = [selectedDict objectForKey: [NSNumber numberWithInt:0]];
    [selectedList replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:YES]];
    
    self.contentTableDelegate.cellSelectedDict = selectedDict;
    
    [self.contentTable setDelegate:self.contentTableDelegate];
    [self.contentTable setDataSource:self.contentTableDelegate];
    self.contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dropdownButton.backgroundColor = [UIColor orangeColor];
    self.dropDownButtonDelegate = mainViewController;
    [mainViewController.view addSubview:self.dropdownButton];
    [mainViewController.view addSubview:self.contentTable];
    [mainViewController.view bringSubviewToFront:self.contentTable];
    
    CGFloat blockViewY = self.contentTable.frame.origin.y + self.contentTable.frame.size.height;
    self.blockView = [[UIView alloc] initWithFrame: CGRectMake(0, blockViewY, mainViewController.view.frame.size.width, mainViewController.view.frame.size.height - blockViewY)];
    self.blockView.hidden = YES;
    self.blockView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBlockView)];
    
    [self.blockView addGestureRecognizer:singleFingerTap];
    [mainViewController.view addSubview:self.blockView];
    [mainViewController.view bringSubviewToFront:self.blockView];
    
    self.contentTable.frame = CGRectMake(self.contentTable.frame.origin.x, self.contentTable.frame.origin.y, self.contentTable.frame.size.width, 0);
}

- (void)setDropdownButtonTitle:(NSString*)title{
    [self.dropdownButton setTitle:title forState:UIControlStateNormal];
}

- (void)setDropdownButtonBackgroundColor:(UIColor*)color{
    [self.dropdownButton setBackgroundColor:color];

}

- (void)setDropdownButtonMutilSelect:(BOOL)canMutilSelected{
    self.contentTableDelegate.canDuplicateSelect = canMutilSelected;

}

- (void)dropdownButtonClicked{
    self.showContentTableView = !self.showContentTableView;
    self.dropdownButton.selected = self.showContentTableView;
    if (self.showContentTableView) {
        [self showAnimation];
        [self.contentTable reloadData];
        
    }else{
        [self hideAnimation];
    
        
    }
    
    [self.dropDownButtonDelegate dropdownButtonDidClick:self.dropdownButton];
    self.blockView.hidden = NO;
    
}
- (void)contentTabledidSelectRowAtIndexPath:(NSIndexPath *)indexPath fromDelegate:(id)delegate{
    self.blockView.hidden = YES;
    self.showContentTableView = NO;
    self.dropdownButton.selected = NO;
    [self hideAnimation];
    [self.dropDownButtonDelegate dropdownContentTableDidSelected:indexPath fromDelegate:delegate];
    
}

- (void)hideBlockView{
    self.blockView.hidden = YES;
    self.showContentTableView = NO;
    self.dropdownButton.selected = NO;
    [self hideAnimation];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^(void) {
                         self.contentTable.frame = CGRectMake(self.contentTable.frame.origin.x, self.contentTable.frame.origin.y, self.contentTable.frame.size.width, 0);

                     }
                     completion:NULL];

}

- (void)showAnimation{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionTransitionCurlDown
                     animations:^(void) {
                         self.contentTable.frame = self.contentFrame;
                     }
                     completion:NULL];

}


@end
