//
//  PPDropdownButton.m
//  PPDropDownMenu
//
//  Created by zhipeng on 16/3/14.
//  Copyright © 2016年 Zhipeng. All rights reserved.
//

#import "PPDropdownButton.h"

@implementation PPDropdownButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setImage:[UIImage imageNamed: @"arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed: @"arrow_up"] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, 0.0, 0.0);
        self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, 0.0, 0.0);

    }
    
    return self;

}

@end
