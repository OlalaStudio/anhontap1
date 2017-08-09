//
//  TLPart4LearningController.h
//  Toeic
//
//  Created by Nguyen Luan on 3/25/17.
//  Copyright (c) 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTableViewCellBase.h"
#import "PartBaseViewController.h"

@interface TLPart5LearningController : PartBaseViewController <UITableViewDelegate, UITableViewDataSource,TLTableViewCellDelegate> {
    NSArray    *_itemList;
    NSMutableDictionary *uDic;
}

@property (weak, nonatomic) IBOutlet UITableView    *tableview;

-(void)setData:(NSArray*)dataArr;

@end
