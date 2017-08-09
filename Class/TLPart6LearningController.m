//
//  TLPart6LearningController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 07/04/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLPart6LearningController.h"
#import "TLQuestionTableViewCell.h"
#import "FCAlertView.h"

@interface TLPart6LearningController ()

@end

@implementation TLPart6LearningController{
    NSString *script;
    NSArray *questions;
    
    NSInteger       rAnwser;
    NSInteger       tAnwser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    uDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"score"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(show_score:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    _textview.text = script;
    
    [self createAnwser1Group];
    [self createAnwser2Group];
    [self createAnwser3Group];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(NSArray *)data{
    dataArr = [[NSArray alloc] initWithArray:data];
    
    script = [data objectAtIndex:1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)viewDidDisappear:(BOOL)animated{
   
}

-(void)show_score:(id)sender{
    
    [self showAnwser];
}

-(void)showAnwser{
    rAnwser = [self findAnwser];
    tAnwser = 3;
    
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
    
    NSLog(@"%@",[self.anwsergroup1 checkedCheckBoxes]);
    NSLog(@"%@",[self.anwsergroup2 checkedCheckBoxes]);
    NSLog(@"%@",[self.anwsergroup3 checkedCheckBoxes]);
    
    NSString *vAnwser1 = [dataArr objectAtIndex:2];
    NSString *vAnwser2 = [dataArr objectAtIndex:3];
    NSString *vAnwser3 = [dataArr objectAtIndex:4];
    
    NSString *uAnwser1 = @"";
    NSString *uAnwser2 = @"";
    NSString *uAnwser3 = @"";
    
    if ([[self.anwsergroup1 checkedCheckBoxes] count] > 0) {
        uAnwser1 = [[[self.anwsergroup1 checkedCheckBoxes] objectAtIndex:0] identifier];
    }
    
    if ([[self.anwsergroup2 checkedCheckBoxes] count] > 0) {
        uAnwser2 = [[[self.anwsergroup2 checkedCheckBoxes] objectAtIndex:0] identifier];
    }
    
    if ([[self.anwsergroup3 checkedCheckBoxes] count] > 0) {
        uAnwser3 = [[[self.anwsergroup3 checkedCheckBoxes] objectAtIndex:0] identifier];
    }
    
    if ([self checkAnwser1:uAnwser1 valid:vAnwser1]) {
        count++;
    }
    
    if ([self checkAnwser1:uAnwser2 valid:vAnwser2]) {
        count++;
    }
    
    if ([self checkAnwser1:uAnwser3 valid:vAnwser3]) {
        count++;
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

-(BOOL)checkAnwser1:(NSString*)uAnwser valid:(NSString*)vAnwser{
    if ([uAnwser isEqualToString:vAnwser]) {
        return YES;
    }
    
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createAnwser1Group {
    TNCircularCheckBoxData *anwserA = [[TNCircularCheckBoxData alloc] init];
    anwserA.identifier = @"A";
    anwserA.labelText = @"A";
    anwserA.checked = NO;
    anwserA.borderColor = [UIColor blackColor];
    anwserA.circleColor = [UIColor orangeColor];
    anwserA.borderRadius = 20;
    anwserA.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserB = [[TNCircularCheckBoxData alloc] init];
    anwserB.identifier = @"B";
    anwserB.checked = NO;
    anwserB.labelText = @"B";
    anwserB.borderColor = [UIColor blackColor];
    anwserB.circleColor = [UIColor orangeColor];
    anwserB.borderRadius = 20;
    anwserB.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserC = [[TNCircularCheckBoxData alloc] init];
    anwserC.identifier = @"C";
    anwserC.labelText = @"C";
    anwserC.borderColor = [UIColor blackColor];
    anwserC.circleColor = [UIColor orangeColor];
    anwserC.borderRadius = 20;
    anwserC.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserD = [[TNCircularCheckBoxData alloc] init];
    anwserD.identifier = @"D";
    anwserD.labelText = @"D";
    anwserD.borderColor = [UIColor blackColor];
    anwserD.circleColor = [UIColor orangeColor];
    anwserD.borderRadius = 20;
    anwserD.circleRadius = 15;
    
    self.anwsergroup1 = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[anwserA, anwserB, anwserC, anwserD] style:TNCheckBoxLayoutHorizontal];
    self.anwsergroup1.rowItemCount = 4;
    [self.anwsergroup1 create];
    self.anwsergroup1.position = CGPointMake(25, 10);
    
    [self.group1 addSubview:self.anwsergroup1];
}

- (void)createAnwser2Group {
    TNCircularCheckBoxData *anwserA = [[TNCircularCheckBoxData alloc] init];
    anwserA.identifier = @"A";
    anwserA.labelText = @"A";
    anwserA.checked = NO;
    anwserA.borderColor = [UIColor blackColor];
    anwserA.circleColor = [UIColor orangeColor];
    anwserA.borderRadius = 20;
    anwserA.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserB = [[TNCircularCheckBoxData alloc] init];
    anwserB.identifier = @"B";
    anwserB.checked = NO;
    anwserB.labelText = @"B";
    anwserB.borderColor = [UIColor blackColor];
    anwserB.circleColor = [UIColor orangeColor];
    anwserB.borderRadius = 20;
    anwserB.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserC = [[TNCircularCheckBoxData alloc] init];
    anwserC.identifier = @"C";
    anwserC.labelText = @"C";
    anwserC.borderColor = [UIColor blackColor];
    anwserC.circleColor = [UIColor orangeColor];
    anwserC.borderRadius = 20;
    anwserC.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserD = [[TNCircularCheckBoxData alloc] init];
    anwserD.identifier = @"D";
    anwserD.labelText = @"D";
    anwserD.borderColor = [UIColor blackColor];
    anwserD.circleColor = [UIColor orangeColor];
    anwserD.borderRadius = 20;
    anwserD.circleRadius = 15;
    
    self.anwsergroup2 = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[anwserA, anwserB, anwserC, anwserD] style:TNCheckBoxLayoutHorizontal];
    self.anwsergroup2.rowItemCount = 4;
    [self.anwsergroup2 create];
    self.anwsergroup2.position = CGPointMake(25, 10);
    
    [self.group2 addSubview:self.anwsergroup2];
}

- (void)createAnwser3Group {
    TNCircularCheckBoxData *anwserA = [[TNCircularCheckBoxData alloc] init];
    anwserA.identifier = @"A";
    anwserA.labelText = @"A";
    anwserA.checked = NO;
    anwserA.borderColor = [UIColor blackColor];
    anwserA.circleColor = [UIColor orangeColor];
    anwserA.borderRadius = 20;
    anwserA.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserB = [[TNCircularCheckBoxData alloc] init];
    anwserB.identifier = @"B";
    anwserB.checked = NO;
    anwserB.labelText = @"B";
    anwserB.borderColor = [UIColor blackColor];
    anwserB.circleColor = [UIColor orangeColor];
    anwserB.borderRadius = 20;
    anwserB.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserC = [[TNCircularCheckBoxData alloc] init];
    anwserC.identifier = @"C";
    anwserC.labelText = @"C";
    anwserC.borderColor = [UIColor blackColor];
    anwserC.circleColor = [UIColor orangeColor];
    anwserC.borderRadius = 20;
    anwserC.circleRadius = 15;
    
    TNCircularCheckBoxData *anwserD = [[TNCircularCheckBoxData alloc] init];
    anwserD.identifier = @"D";
    anwserD.labelText = @"D";
    anwserD.borderColor = [UIColor blackColor];
    anwserD.circleColor = [UIColor orangeColor];
    anwserD.borderRadius = 20;
    anwserD.circleRadius = 15;
    
    self.anwsergroup3 = [[TNCheckBoxGroup alloc] initWithCheckBoxData:@[anwserA, anwserB, anwserC, anwserD] style:TNCheckBoxLayoutHorizontal];
    self.anwsergroup3.rowItemCount = 4;
    [self.anwsergroup3 create];
    self.anwsergroup3.position = CGPointMake(25, 10);
    
    [self.group3 addSubview:self.anwsergroup3];
}

@end
