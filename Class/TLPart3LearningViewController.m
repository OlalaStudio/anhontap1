//
//  TLPart3ViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 24/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLPart3LearningViewController.h"
#import "TLQuestionTableViewCell.h"
#import "FCAlertView.h"

@interface TLPart3LearningViewController ()

@end

@implementation TLPart3LearningViewController{
    NSString *strId;
    NSString *audio;
    NSString *strQuestion;
    NSString *strAnswer;
    NSString *strTranscript;
    
    NSMutableArray *questions;
    NSMutableDictionary *uDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    
    [_tableview registerNib:[UINib nibWithNibName:@"TLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"idnormalcell"];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"script"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(show_Script:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [_scriptview setText:strTranscript];
    [_scriptview setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
//    [_playerBar setPlayerURL:audio];
    [_playerBar setPlayerBarDelegate:self];
//    [_playerBar loadContent];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [_playerBar stop];
}

-(void)setData:(NSArray *)dataArr{
    strId = [dataArr objectAtIndex:0];
    audio = [dataArr objectAtIndex:1];
    strQuestion = [dataArr objectAtIndex:2];
    strAnswer = [dataArr objectAtIndex:3];
    strTranscript = [dataArr objectAtIndex:4];
    
    [self initQuestions];
    
    NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:strId, @"id",
                          audio, @"audio",
                          questions, @"question",
                          strAnswer, @"answer",
                          strTranscript, @"transcript",nil];
    
    _itemList = [[NSDictionary alloc] initWithDictionary:item];
}

-(void)show_Script:(id)sender
{
    // code for right Button
    [_scriptview setHidden:![_scriptview isHidden]];
}

-(void)initQuestions{
    questions = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *subcomponents = [strQuestion componentsSeparatedByString:@"\n"];
    for (int i=0; i<[subcomponents count]; i++) {
        
        NSString *substr = [subcomponents objectAtIndex:i];
        
        if ([substr rangeOfString:@"1)."].location != NSNotFound ||
            [substr rangeOfString:@"2)."].location != NSNotFound ||
            [substr rangeOfString:@"3)."].location != NSNotFound) {
            
            NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] initWithCapacity:0];
            [itemDic setObject:substr forKey:@"question"];
            [itemDic setObject:[subcomponents objectAtIndex:i+1] forKey:@"A"];
            [itemDic setObject:[subcomponents objectAtIndex:i+2] forKey:@"B"];
            [itemDic setObject:[subcomponents objectAtIndex:i+3] forKey:@"C"];
            [itemDic setObject:[subcomponents objectAtIndex:i+4] forKey:@"D"];
            
            NSString *subAnws = [strAnswer substringWithRange:NSMakeRange([questions count], 1)];
            
            [itemDic setObject:subAnws forKey:@"answer"];
            
            [questions addObject:itemDic];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [questions count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TLQuestionTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"idnormalcell"];
    [cell setQNumber:indexPath.section * 2 + indexPath.row];
    [cell setData:[questions objectAtIndex:indexPath.row]];
    [cell setIndex:indexPath];
        
    return cell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //update data
//    AnwserState state = [[uDic objectForKey:indexPath] integerValue];
//    [(TLTableViewCellBase*)cell updateSelection:state];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma mark - Player Bar Delegate
-(void)didFinishPlayer{
    
    //show score
    NSLog(@"Show score");
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
    
    int correctCount = 0;
    
    NSInteger sections = _tableview.numberOfSections;

    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [_tableview numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            TLTableViewCellBase *cell = [self.tableview cellForRowAtIndexPath:indexPath];
            
            if([cell checkAnwser]){
                correctCount++;
            }
        }
    }
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    
    if (correctCount > 0) {
        NSString *correctcountStr = [NSString stringWithFormat:@"%ld / %lu",(long)correctCount,(unsigned long)[questions count]];
        [alert showAlertWithTitle:@"Correct!" withSubtitle:correctcountStr withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        [alert makeAlertTypeSuccess];
    }
    else{
        [alert showAlertWithTitle:@"Wrong!" withSubtitle:nil withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        [alert makeAlertTypeWarning];
    }
    
    if (_adsloaded) {
        _adsloaded = NO;
        [_interstitial presentFromRootViewController:self];
    }
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

@end
