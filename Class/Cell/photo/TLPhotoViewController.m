//
//  TLPhotoViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 15/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLPhotoViewController.h"

@interface TLPhotoViewController (){
    NSString *avata;
    NSString *script;
    NSString *audio;
}

@end

@implementation TLPhotoViewController
@dynamic anwser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _anwser = kUnknow;
    
    [self deSelectAll];
    
    [self setupView];
}

-(void)viewDidAppear:(BOOL)animated{
//    [_playerBar setPlayerURL:audio];
    [_playerBar setPlayerBarDelegate:self];
//    [_playerBar loadContent];
}

-(void)viewDidDisappear:(BOOL)animated{
//    [_playerBar stop];
    [_player stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(NSDictionary *)data{
    _dataDic = [[NSDictionary alloc] initWithDictionary:data];
}

-(void)setupView{
    
    avata = [NSString stringWithFormat:@"%@.jpg",[_dataDic valueForKey:@"audio"]];
    audio = [NSString stringWithFormat:@"%@.mp3",[_dataDic valueForKey:@"audio"]];
    script = [_dataDic valueForKey:@"transcript"];
    
    [_picture setImage:[UIImage imageNamed:avata]];
    [_scriptview setText:script];
    
    [_scriptview setHidden:YES];
}

-(void)showAnwser:(BOOL)result{
    [super showAnwser:result];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)show_script{
    [_scriptview setHidden:![_scriptview isHidden]];
}

-(void)checkAnwser{
    NSString *validAnwser = [_dataDic objectForKey:@"answer"];
    AnwserState validAnwserSt = kUnknow;
    
    if ([[validAnwser uppercaseString] isEqualToString:@"A"]) {
        validAnwserSt = kAnwserA;
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"B"]){
        validAnwserSt = kAnwserB;
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"C"]){
        validAnwserSt = kAnwserC;
    }
    else if ([[validAnwser uppercaseString] isEqualToString:@"D"]){
        validAnwserSt = kAnwserD;
    }
    
    if (_anwser != validAnwserSt) {
        [self showAnwser:NO];
        return;
    }
    
    [self showAnwser:YES];
}

#pragma mark - UIAction
-(IBAction)select_A:(id)sender{
    NSLog(@"[Photo]select A");
    
    _anwser = kAnwserA;
    
    [self deSelectAll];
    
    [self.anwser_A.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_A setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_B:(id)sender{
    NSLog(@"[Photo]select B");
    
    _anwser = kAnwserB;
    
    [self deSelectAll];
    
    [self.anwser_B.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_B setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_C:(id)sender{
    NSLog(@"[Photo]select C");
    
    _anwser = kAnwserC;
    
    [self deSelectAll];
    
    [self.anwser_C.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_C setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_D:(id)sender{
    NSLog(@"[Photo]select D");
    
    _anwser = kAnwserD;
    
    [self deSelectAll];
    
    [self.anwser_D.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_D setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(void)deSelectAll{
    
    [self.anwser_A.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_B.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_C.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_D.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    [self.anwser_A setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_B setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_C setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_D setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
}

#pragma mark - Player Bar Delegate
-(void)didFinishPlayer{
    
    //show score
    NSLog(@"Show score");
    
    [self checkAnwser];
}

-(void)didClickPlayer
{
    if (!_player) {
        NSString *soundFilePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],audio];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSError *error = nil;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        [_player setDelegate:self];
        _player.volume = 1.0;
        
        if([[NSFileManager defaultManager] fileExistsAtPath:soundFilePath]){
            
            [_player prepareToPlay];
            
            if(![_player play]){
                NSLog(@"speak fail %@",audio);
            }
        }
    }
    else{
        if ([_player isPlaying]) {
            [_player pause];
        }
        else{
            [_player play];
        }
    }
}

-(void)canClickPlayer
{
    
}

#pragma mark - Player Delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //show score
    NSLog(@"Show score");
    
    [self checkAnwser];
}
@end
