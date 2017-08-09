//
//  Part5ViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 13/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "Part5ViewController.h"
#import "TLPart5LearningController.h"
#import "TLTableViewCell.h"
#import "TDatabaseManager.h"

@interface Part5ViewController ()

@end

@implementation Part5ViewController{
    NSMutableArray *dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sideBarButton setTarget:revealViewController];
        [self.sideBarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    
    [_tableview registerNib:[UINib nibWithNibName:@"TLTableViewCell" bundle:nil] forCellReuseIdentifier:@"idCellNormal"];
    
    dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self initDatabase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initDatabase{
    
    TDatabaseManager *dbManager = [TDatabaseManager sharedInstance];
    
    if([dbManager open:@"data_reading.db"]){
        
        NSString *query = @"SELECT * FROM part5";
        
        // Get the results.
        NSArray *loadData = [NSMutableArray arrayWithArray:[dbManager loadDataFromDB:query]];
        
        [self convertLoadedDataBase:loadData];
        
        [dbManager close];
    }
}

-(void)convertLoadedDataBase:(NSArray*)loaddata{
    
    for (int i=0; i < [loaddata count]; i=i+10) {
        
        //lesson
        NSMutableArray *arrLesson = [[NSMutableArray alloc] initWithCapacity:0];
        
        //array qestion for lesson
        NSMutableDictionary *dicquestion = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        for (int j = i; j < i+10; j++) {
            
            NSArray *item = [loaddata objectAtIndex:j];
            
            [dicquestion setValue:[item objectAtIndex:1] forKey:@"question"];
            [dicquestion setValue:[item objectAtIndex:2] forKey:@"A"];
            [dicquestion setValue:[item objectAtIndex:3] forKey:@"B"];
            [dicquestion setValue:[item objectAtIndex:4] forKey:@"C"];
            [dicquestion setValue:[item objectAtIndex:5] forKey:@"D"];
            
            NSString *an = [item objectAtIndex:6];
            
            [dicquestion setValue:[self convertAnwser:[an integerValue]] forKey:@"answer"];
            
            [arrLesson addObject:dicquestion];
        }
        
        [dataArr addObject:arrLesson];
    }
}

-(NSString*)convertAnwser:(NSInteger)an{
    switch (an) {
        case 1:
            return @"A";
        case 2:
            return @"B";
        case 3:
            return @"C";
        case 4:
            return @"D";
        default:
            break;
    }
    
    return @"";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArr count];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _adBannerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _adBannerView.frame.size.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellNormal"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.textColor = [UIColor grayColor];
    
    NSString *title     = [NSString stringWithFormat:@"Incomplete Sentences Test %ld",(long)indexPath.row + 1];
    NSString *avate     = @"part5.png";
    
    [cell setDisplayTitle:title];
    [cell setDisplayAvata:avate];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TLPart5LearningController *lessonViewController = (TLPart5LearningController*)[self.storyboard instantiateViewControllerWithIdentifier:@"idvpart5"];
    
    [lessonViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [lessonViewController setData:[dataArr objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:lessonViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
