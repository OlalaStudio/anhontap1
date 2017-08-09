//
//  Part7ViewController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 13/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "Part7ViewController.h"
#import "TLPart7LearningController.h"
#import "TLTableViewCell.h"
#import "TDatabaseManager.h"

@interface Part7ViewController ()

@end

@implementation Part7ViewController{
    NSArray  *dataArr;
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

    //init database
//    [self initDatabase];
    
    NSString *metadataPath = [[NSBundle mainBundle] pathForResource:@"part7metadata" ofType:@"plist"];
    
    dataArr = [[NSArray alloc] initWithContentsOfFile:metadataPath];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initDatabase{
    
    TDatabaseManager *dbManager = [TDatabaseManager sharedInstance];
    
    if([dbManager open:@"data_reading.db"]){
        
        NSString *query = @"SELECT * FROM part7";
        
        // Get the results.
        dataArr = [NSMutableArray arrayWithArray:[dbManager loadDataFromDB:query]];
        
        [dbManager close];
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
    
    NSString *title     = [NSString stringWithFormat:@"Reading Comprehension Test %ld",(long)indexPath.row + 1];
    NSString *avate     = @"part7.png";
    
    [cell setDisplayTitle:title];
    [cell setDisplayAvata:avate];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TLPart7LearningController *lessonViewController = (TLPart7LearningController*)[self.storyboard instantiateViewControllerWithIdentifier:@"idvpart7"];
    
    [lessonViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [lessonViewController setData:[dataArr objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:lessonViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
