//
//  NavigationVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/23.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NavigationVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface NavigationVC ()<MAMapViewDelegate>{

    MAMapView *_mapView;
}
@property (nonatomic) BOOL isFirstAppear;
@end

@implementation NavigationVC
@synthesize mapView = _mapView;


- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)hookAction
{
}

-(void)returnAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self clearMapView];
}

#pragma InitIntailzation

-(void)initMapview{
    
    self.mapView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    self.mapView.backgroundColor = [UIColor redColor];
    self.mapView.mapType = MAMapTypeSatellite;
    //开启定位开关
    _mapView.showsUserLocation = YES;
    _mapView.showsCompass = YES;
    _mapView.scrollEnabled = NO;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动

      self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isFirstAppear) {
        _isFirstAppear = NO;
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //高德地图apiKey
    [AMapServices sharedServices].apiKey = @"d3d12fc125e346b157b1931e0c0474d8";
    
//    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//    _mapView.delegate = self;
//    [self.view addSubview:_mapView];
//    //开启定位开关
//    _mapView.showsUserLocation = YES;
   
    
    
    
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}


//- (void)dealloc
//{
//    self.mamapview.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
//}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"] ?: [bundleInfo valueForKey:@"CFBundleName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    return scheme;
}



//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
}


//用户位置跟新时追踪更新信息
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
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
