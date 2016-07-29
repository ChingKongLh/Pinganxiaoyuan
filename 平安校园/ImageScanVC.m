//
//  ImageScanVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/23.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "ImageScanVC.h"
#import <AVFoundation/AVFoundation.h>
@interface ImageScanVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIView *preview;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@property (nonatomic,strong)AVCaptureDevice *device;
@property (nonatomic,strong)AVCaptureInput *input;
@property (nonatomic,strong)AVCaptureMetadataOutput *output;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *layer;

@property (nonatomic,strong)UIImageView *img;
@property (nonatomic)NSTimer *timer;
@end

@implementation ImageScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preparetoscan];
    [self startReading];
}

-(void)preparetoscan{
    UIImage *image=  [[UIImage imageNamed:@"qrcode_border"]resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 26, 26)];
    [self.imageview setImage:image];
    
    UIImageView *umageviewss= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qrcode_scanline_qrcode"]];
    
    umageviewss.frame = self.imageview.bounds;
    [self.imageview addSubview:umageviewss];
    self.imageview.clipsToBounds = YES;
    self.img  =umageviewss;
    
    self.img.frame = CGRectMake(0, -self.imageview.frame.size.height, self.imageview.frame.size.width, self.imageview.frame.size.height);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(change:) userInfo:nil repeats:YES];

//    UIImage *image = [[UIImage imageNamed:@"qrcode_border"]resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 26, 26)];
//    [self.imageview setImage:image];
//    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qrcode_scanline_qrcode"]];
//    imageview.frame = self.imageview.bounds;
//    [self.imageview addSubview:imageview];
//    self.imageview.clipsToBounds = YES;
//    self.imageview = imageview;
//    
//    self.img.frame = CGRectMake(0, -self.imageview.frame.size.height, self.imageview.frame.size.width, self.imageview.frame.size.height);
//    
//    //设定定时器，限定刷新频率
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(change:) userInfo:nil repeats:YES];
}

-(void)change:(NSTimer *)timer{
    self.img.frame = CGRectOffset(self.img.frame, 0, 5);
    if (self.img.frame.origin.y > self.imageview.frame.size.height) {
        self.img.frame = CGRectMake(0, -self.imageview.frame.size.height, self.imageview.frame.size.width, self.imageview.frame.size.height);
    }
    
}

-(void)startReading{

    //1.初始化device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];//获取视频设备
    //2.设备关联input
    NSError *error;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    //3.创建session
    self.session =[[AVCaptureSession alloc] init];
    //添加input
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    //4.创建output
    self.output = [[AVCaptureMetadataOutput alloc] init];
    //5.创建队列用于output输出结果
    dispatch_queue_t queur = dispatch_queue_create("myqueue", NULL);
    [self.output setMetadataObjectsDelegate:self queue:queur];
    
    //6.将output添加到session中
    [self.session addOutput:self.output];
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeUPCECode,
                                          AVMetadataObjectTypeCode39Code,
                                          AVMetadataObjectTypeCode39Mod43Code,
                                          AVMetadataObjectTypeEAN13Code,
                                          AVMetadataObjectTypeEAN8Code,
                                          AVMetadataObjectTypeCode93Code,
                                          AVMetadataObjectTypeCode128Code,
                                          AVMetadataObjectTypePDF417Code,
                                          AVMetadataObjectTypeQRCode]];
    //8.配置预览效果
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [layer setFrame:self.preview.layer.frame];
    [self.preview.layer addSublayer:layer];
    
    //启动整个过程
    [self.session startRunning];
  }

-(void)read:(NSString *)rading{
    [self.session startRunning];
    if (self.navigationController.viewControllers.count == 1) {
        UIViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"scan"];
        [self presentViewController:VC animated:YES completion:nil];
    }
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count != 0) {
        AVMetadataMachineReadableCodeObject *Read = (AVMetadataMachineReadableCodeObject *)metadataObjects.firstObject;
        //开启异步线程处理扫描结果
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self read:Read.stringValue];
        });
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
