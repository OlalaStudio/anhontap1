//
//  Part5ViewController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 13/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartBaseViewController.h"
#import "SWRevealViewController.h"

@interface Part5ViewController : PartBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITableView     *tableview;

@end
