//
//  TLPart2LearningController.m
//  Toeic
//
//  Created by NguyenThanhLuan on 23/03/2017.
//  Copyright © 2017 Olala. All rights reserved.
//

#import "TLPart2LearningController.h"


@interface TLPart2LearningController ()

@end

@implementation TLPart2LearningController{
    NSString *strId;
    NSString *audio;
    NSString *strQuestion;
    NSString *strAnswer;
    NSString *strTranscript;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"script"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(show_Script:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    //setup page
    [self setupPageView];
    
    [self.view addSubview:_adBannerView];
    
    CGRect frame = [self.view frame];
    CGRect bannerrect = [_adBannerView frame];
    
    bannerrect.origin.y = frame.size.height - 50;
    [_adBannerView setFrame:bannerrect];
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

-(void)setData:(NSArray *)dataArr{
    
    strId = [dataArr objectAtIndex:0];
    audio = [NSString stringWithFormat:@"part2/%@",[dataArr objectAtIndex:1]];
    strQuestion = [dataArr objectAtIndex:2];
    strAnswer = [dataArr objectAtIndex:3];
    strTranscript = [dataArr objectAtIndex:4];
    
    NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:strId, @"id",
                          audio, @"audio",
                          strQuestion, @"question",
                          strAnswer, @"answer",
                          strTranscript, @"transcript",nil];
    
    _itemList = [[NSArray alloc] initWithObjects:item, nil];
}

-(void)show_Script:(id)sender
{
    // code for right Button
    
    TLQnRViewController *currentView = (TLQnRViewController*)[_controllerArr objectAtIndex:[self.pageControll currentPage]];
    
    [currentView show_script];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setupPageView{
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    TLQnRViewController *initialView = [self viewControllerAtIndex:0];
    
    _controllerArr = [NSMutableArray arrayWithObject:initialView];
    
    [self.pageController setViewControllers:_controllerArr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    
    [self.pageController didMoveToParentViewController:self];
    [self addPageControll];
    
    [initialView didMoveToParentViewController:self];
}

#pragma mark
#pragma mark PageViewControllerDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    TLQnRViewController *pageContentView = (TLQnRViewController*)pendingViewControllers[0];
    [self.pageControll setCurrentPage:[pageContentView index]];
    [self.pageControll updateCurrentPageDisplay];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [(TLQnRViewController*)viewController index];
    
    index++;
    
    if (index > [_itemList count] - 1) {
        return nil;
    }
    
    if ([_controllerArr count] <= index) {
        [_controllerArr addObject:[self viewControllerAtIndex:index]];
    }
    
    return [_controllerArr objectAtIndex:index];
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [(TLQnRViewController*)viewController index];
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [_controllerArr objectAtIndex:index];
}

-(TLQnRViewController*)viewControllerAtIndex:(NSInteger)index
{
    TLQnRViewController *pageviewcontroller = [[TLQnRViewController alloc] initWithNibName:@"TLQnRViewController" bundle:nil];
    [pageviewcontroller setData:[_itemList objectAtIndex:index]];
    pageviewcontroller.index = index;
    [pageviewcontroller.view setFrame:[[self view] frame]];
    
    return pageviewcontroller;
}

-(void)addPageControll
{
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    [self.pageControll setTintColor:[UIColor orangeColor]];
    [self.pageControll setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [self.pageControll setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [self.pageControll setHidesForSinglePage:YES];
    [self.pageControll setNumberOfPages:[_itemList count]];
    [self.pageControll setCurrentPage:0];
    [self.view addSubview:self.pageControll];
}

@end
