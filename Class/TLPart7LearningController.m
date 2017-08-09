//
//  TLPart7LearningController.m
//  Toeic
//
//  Created by Nguyen Luan on 4/6/17.
//  Copyright (c) 2017 Olala. All rights reserved.
//

#import "TLPart7LearningController.h"
#import "TLQuestionTableViewCell.h"
#import "FCAlertView.h"

@interface TLPart7LearningController ()

@end

@implementation TLPart7LearningController{
    NSArray *question;
    NSString *script;
    
    NSInteger       rAnwser;
    NSInteger       tAnwser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview registerNib:[UINib nibWithNibName:@"TLQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"idnormalcell"];
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"script"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(show_script:)];
    
    UIBarButtonItem *scoreBtn = [[UIBarButtonItem alloc]initWithTitle:@"score"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(show_score:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationItem setRightBarButtonItems:@[scoreBtn,rightBtn]];
    
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:script ofType:@"rtf"];
    
    _textview.attributedText =[[NSAttributedString alloc] initWithFileURL:[NSURL fileURLWithPath:scriptPath]
                                                                    options:nil
                                                         documentAttributes:nil
                                                                      error:nil];
    
    [_textview setHidden:YES];
    [_tableview setHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(NSDictionary *)data{
    dataDic = [NSDictionary dictionaryWithDictionary:data];
    
    question = [dataDic valueForKey:@"question"];
    script = [dataDic valueForKey:@"script"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
   
}

-(void)viewDidDisappear:(BOOL)animated{
    
}

-(void)show_script:(id)sender{
    [_textview setHidden:![_textview isHidden]];
    [_tableview setHidden:![_tableview isHidden]];
}

-(void)show_score:(id)sender{
    [self showAnwser];
}

-(void)showAnwser{
    rAnwser = [self findAnwser];
    tAnwser = [question count];
    
    FCAlertView *alert = [[FCAlertView alloc] init];
    
    if (rAnwser > 0) {
        NSString *correctcountStr = [NSString stringWithFormat:@"%ld / %lu",(long)rAnwser,(unsigned long)tAnwser];
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

-(NSInteger)findAnwser{
    
    NSInteger count = 0;
    
    NSInteger session = [_tableview numberOfSections];
    for (int i=0; i<session; i++) {
        NSInteger row = [_tableview numberOfRowsInSection:i];
        
        for (int j=0; j<row; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            
            AnwserState anwser = [[uDic objectForKey:indexpath] integerValue];
            
            NSDictionary* itemDic = [question objectAtIndex:j];
            
            if ([self checkAnwser:anwser valid:[itemDic objectForKey:@"answer"]]) {
                count++;
            }
        }
    }
    
    return count;
}

-(BOOL)checkAnwser:(AnwserState)uAnwser valid:(NSString*)vAnwser{
    
    AnwserState validAnwserSt = kUnknow;
    
    if ([[vAnwser uppercaseString] isEqualToString:@"A"]) {
        validAnwserSt = kAnwserA;
    }
    else if ([[vAnwser uppercaseString] isEqualToString:@"B"]){
        validAnwserSt = kAnwserB;
    }
    else if ([[vAnwser uppercaseString] isEqualToString:@"C"]){
        validAnwserSt = kAnwserC;
    }
    else if ([[vAnwser uppercaseString] isEqualToString:@"D"]){
        validAnwserSt = kAnwserD;
    }
    
    if (uAnwser != validAnwserSt) {
        return NO;
    }
    
    return YES;
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
    
    return [question count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TLQuestionTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"idnormalcell"];
    [cell setDelegate:self];
    [cell setQNumber:indexPath.row];
    [cell setData:[question objectAtIndex:indexPath.row]];
    [cell setIndex:indexPath];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //update data
    AnwserState state = [[uDic objectForKey:indexPath] integerValue];
    [(TLTableViewCellBase*)cell updateSelection:state];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma mark -
#pragma mark - UITableCellView Delegate
-(void)didSelectAnwser:(AnwserState)anwser forCell:(TLTableViewCellBase *)cell{
    
    NSIndexPath *indexpath = [cell index];
    
    [uDic setObject:[NSNumber numberWithInteger:anwser] forKey:indexpath];
}

@end
