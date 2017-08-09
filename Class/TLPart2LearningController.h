//
//  TLPart2LearningController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLQnRViewController.h"
#import "PartBaseViewController.h"

@interface TLPart2LearningController : PartBaseViewController <UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    NSArray          *_itemList;
    NSMutableArray   *_controllerArr;
}

@property (strong,nonatomic) UIPageViewController   *pageController;
@property (strong,nonatomic) UIPageControl          *pageControll;

-(void)setData:(NSArray*)dataArr;

@end
