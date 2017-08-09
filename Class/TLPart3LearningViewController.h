//
//  TLPart3ViewController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 24/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PlayerBarView.h"
#import "PartBaseViewController.h"

@interface TLPart3LearningViewController : PartBaseViewController <UITableViewDelegate,UITableViewDataSource,PlayerBarViewDelegate,AVAudioPlayerDelegate>{
    NSDictionary          *_itemList;
}

@property (weak, nonatomic) IBOutlet PlayerBarView *playerBar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextView *scriptview;

@property(nonatomic, retain) AVAudioPlayer *player;

-(void)setData:(NSArray *)dataArr;

@end
