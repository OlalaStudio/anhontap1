//
//  PhotoViewController.h
//  SlideOutMenu
//
//  Created by NguyenThanhLuan on 14/12/2016.
//  Copyright © 2016 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartBaseViewController.h"
#import "SWRevealViewController.h"

@interface Part3ViewController : PartBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITableView     *tableview;

@end
