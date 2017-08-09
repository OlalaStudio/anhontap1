//
//  TLPart6LearningController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 07/04/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartBaseViewController.h"
#import "TLTableViewCellBase.h"
#import "TNCheckBoxGroup.h"

@interface TLPart6LearningController : PartBaseViewController{
    NSArray *dataArr;
    NSMutableDictionary *uDic;
    
}

@property (weak, nonatomic) IBOutlet UITextView  *textview;
@property (weak, nonatomic) IBOutlet UIView     *group1;
@property (weak, nonatomic) IBOutlet UIView     *group2;
@property (weak, nonatomic) IBOutlet UIView     *group3;

@property (nonatomic, strong) TNCheckBoxGroup *anwsergroup1;
@property (nonatomic, strong) TNCheckBoxGroup *anwsergroup2;
@property (nonatomic, strong) TNCheckBoxGroup *anwsergroup3;


-(void)setData:(NSArray*)data;

@end
