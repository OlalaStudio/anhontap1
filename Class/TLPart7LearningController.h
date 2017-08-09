//
//  TLPart7LearningController.h
//  Toeic
//
//  Created by Nguyen Luan on 4/6/17.
//  Copyright (c) 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartBaseViewController.h"
#import "TLTableViewCellBase.h"

@interface TLPart7LearningController : PartBaseViewController <UITableViewDelegate, UITableViewDataSource, TLTableViewCellDelegate>{
    NSDictionary *dataDic;
    NSMutableDictionary *uDic;
}

@property (weak, nonatomic) IBOutlet UITableView    *tableview;
@property (weak, nonatomic) IBOutlet UITextView     *textview;

-(void)setData:(NSDictionary*)data;

@end
