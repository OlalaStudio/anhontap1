//
//  TLPhotoViewController.h
//  Toeic
//
//  Created by NguyenThanhLuan on 15/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TLBaseViewController.h"
#import "PlayerBarView.h"

@interface TLPhotoViewController : TLBaseViewController <PlayerBarViewDelegate, AVAudioPlayerDelegate>{
    NSDictionary    *_dataDic;
}

@property (assign,nonatomic) NSInteger  index;

@property (weak, nonatomic) IBOutlet PlayerBarView  *playerBar;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UITextView *scriptview;
@property (weak, nonatomic) IBOutlet UIButton *anwser_A;
@property (weak, nonatomic) IBOutlet UIButton *anwser_B;
@property (weak, nonatomic) IBOutlet UIButton *anwser_C;
@property (weak, nonatomic) IBOutlet UIButton *anwser_D;

@property(nonatomic, retain) AVAudioPlayer *player;

-(IBAction)select_A:(id)sender;
-(IBAction)select_B:(id)sender;
-(IBAction)select_C:(id)sender;
-(IBAction)select_D:(id)sender;

-(void)setData:(NSDictionary*)data;
-(void)show_script;
@end
