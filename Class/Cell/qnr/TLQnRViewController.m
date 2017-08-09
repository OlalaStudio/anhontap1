//
//  TLQnRViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLQnRViewController.h"

@interface TLQnRViewController (){
    AnwserState _anwser1;
    AnwserState _anwser2;
    AnwserState _anwser3;
    
    NSString *script;
    NSString *audio;
}

@end

@implementation TLQnRViewController
@dynamic anwser;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _anwser = kUnknow;
    _anwser1 = kUnknow;
    _anwser2 = kUnknow;
    _anwser3 = kUnknow;
    
    [self deSelectAll1];
    [self deSelectAll2];
    [self deSelectAll3];
    
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

    audio = [NSString stringWithFormat:@"%@.mp3",[_dataDic valueForKey:@"audio"]];
    script = [_dataDic valueForKey:@"transcript"];
    
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
    
    [self didFinishPlayer];
}

-(BOOL)checkAnwser:(AnwserState)uAnwser validAnwser:(NSString*)validAnwser {

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
    
    if (uAnwser != validAnwserSt) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Target/Action
-(IBAction)select_A1:(id)sender{
    NSLog(@"[Q&R]select A1");
    
    _anwser1 = kAnwserA;
    
    [self deSelectAll1];
    
    [self.anwser_A1.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_A1 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_A2:(id)sender{
    NSLog(@"[Q&R]select A2");
    
    _anwser2 = kAnwserA;
    
    [self deSelectAll2];
    
    [self.anwser_A2.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_A2 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_A3:(id)sender{
    NSLog(@"[Q&R]select A3");
    
    _anwser3 = kAnwserA;
    
    [self deSelectAll3];
    
    [self.anwser_A3.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_A3 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_B1:(id)sender{
    NSLog(@"[Q&R]select B1");
    
    _anwser1 = kAnwserB;
    
    [self deSelectAll1];
    
    [self.anwser_B1.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_B1 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_B2:(id)sender{
    NSLog(@"[Q&R]select B2");
    
    _anwser2 = kAnwserB;
    
    [self deSelectAll2];
    
    [self.anwser_B2.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_B2 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_B3:(id)sender{
    NSLog(@"[Q&R]select B3");
    
    _anwser3 = kAnwserB;
    
    [self deSelectAll3];
    
    [self.anwser_B3.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_B3 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_C1:(id)sender{
    NSLog(@"[Q&R]select C1");
    
    _anwser1 = kAnwserC;
    
    [self deSelectAll1];
    
    [self.anwser_C1.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_C1 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_C2:(id)sender{
    NSLog(@"[Q&R]select C2");
    
    _anwser2 = kAnwserC;
    
    [self deSelectAll2];
    
    [self.anwser_C2.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_C2 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(IBAction)select_C3:(id)sender{
    NSLog(@"[Q&R]select C3");
    
    _anwser3 = kAnwserC;
    
    [self deSelectAll3];
    
    [self.anwser_C3.titleLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [self.anwser_C3 setTitleColor:SELECT_COLOR forState:UIControlStateNormal];
}

-(void)deSelectAll1{
    
    [self.anwser_A1.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_B1.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_C1.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    [self.anwser_A1 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_B1 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_C1 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
}

-(void)deSelectAll2{
    
    [self.anwser_A2.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_B2.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_C2.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    [self.anwser_A2 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_B2 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_C2 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
}

-(void)deSelectAll3{
    
    [self.anwser_A3.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_B3.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self.anwser_C3.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    [self.anwser_A3 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_B3 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
    [self.anwser_C3 setTitleColor:DESELECT_COLOR forState:UIControlStateNormal];
}

#pragma mark - Player Bar Delegate
-(void)didFinishPlayer{
    
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
    
    NSString *anwsers = [_dataDic objectForKey:@"answer"];
    NSInteger correctCount = 0;
    
    if([self checkAnwser:_anwser1 validAnwser:[anwsers substringWithRange:NSMakeRange(0, 1)]]){
        correctCount ++;
    }
    
    if([self checkAnwser:_anwser2 validAnwser:[anwsers substringWithRange:NSMakeRange(1, 1)]]){
        correctCount ++;
    }
    
    if([self checkAnwser:_anwser3 validAnwser:[anwsers substringWithRange:NSMakeRange(2, 1)]]){
        correctCount ++;
    }
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    
    if (correctCount > 0) {
        NSString *correctcountStr = [NSString stringWithFormat:@"%ld / %lu",(long)correctCount,(unsigned long)[anwsers length]];
        [alert showAlertWithTitle:@"Correct!" withSubtitle:correctcountStr withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        [alert makeAlertTypeSuccess];
    }
    else{
        [alert showAlertWithTitle:@"Wrong!" withSubtitle:nil withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        [alert makeAlertTypeWarning];
    }
}

@end
