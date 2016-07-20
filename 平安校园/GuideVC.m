//
//  GuideVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "GuideVC.h"
#import "AppDelegate.h"
@interface GuideVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIPageControl *PageControl;

@end

@implementation GuideVC
- (IBAction)moveToMain:(id)sender {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate guideEnd];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollview.delegate = self;
    self.PageControl.numberOfPages = 4;
}


#pragma mark ---ScrollViewDelegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        self.PageControl.currentPage = self.scrollview.contentOffset.x / self.scrollview.frame.size.width;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.PageControl.currentPage = self.scrollview.contentOffset.x / self.scrollview.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
