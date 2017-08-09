//
//  TLQnRViewController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "PlayerBarView.h"
#import "TLBaseViewController.h"

@interface TLQnRViewController : TLBaseViewController <PlayerBarViewDelegate,AVAudioPlayerDelegate>{
    NSDictionary    *_dataDic;
}

@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) IBOutlet PlayerBarView  *playerBar;

@property (weak, nonatomic) IBOutlet UITextView  *scriptview;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_A1;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_A2;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_A3;

@property (weak, nonatomic) IBOutlet UIButton    *anwser_B1;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_B2;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_B3;

@property (weak, nonatomic) IBOutlet UIButton    *anwser_C1;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_C2;
@property (weak, nonatomic) IBOutlet UIButton    *anwser_C3;

@property(nonatomic, retain) AVAudioPlayer *player;

-(IBAction)select_A1:(id)sender;
-(IBAction)select_A2:(id)sender;
-(IBAction)select_A3:(id)sender;

-(IBAction)select_B1:(id)sender;
-(IBAction)select_B2:(id)sender;
-(IBAction)select_B3:(id)sender;

-(IBAction)select_C1:(id)sender;
-(IBAction)select_C2:(id)sender;
-(IBAction)select_C3:(id)sender;

-(void)setData:(NSDictionary*)data;
-(void)show_script;
@end
