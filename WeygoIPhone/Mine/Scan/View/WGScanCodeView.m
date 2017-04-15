//
//  WGScanCodeView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGScanCodeView.h"
#import <AVFoundation/AVFoundation.h>
#define SelfW self.bounds.size.width
#define SelfH self.bounds.size.height
#define ScanLineH 30

@interface WGScanCodeView ()<AVCaptureMetadataOutputObjectsDelegate> // 用于处理采集信息的代理
{
    AVCaptureSession *session; // 输入输出的中间桥梁
    CAGradientLayer *scanLayer;
    UIView *scanBox;
}

@end

@implementation WGScanCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 创建输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        // 创建输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        
        // 设置代理，在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 初始化链接对象
        session = [[AVCaptureSession alloc]init];
        
        // 高质量采集率
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        
        [session addInput:input];
        [session addOutput:output];
        
        
        // 设置扫码支持的编码格式（如下设置条形码和二维码兼容）
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
        
        // 实例化预览图层
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        // 设置预览图层填充方式
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer.frame = self.layer.bounds;
        [self.layer insertSublayer:layer atIndex:0];
        UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SelfW,SelfH)];
        
        [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [self addSubview:maskView];
        
        
        // 运用贝塞尔曲线配合CAShapeLayer
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SelfW, SelfH)];
        
        // MARK: circlePath 画圆
        // [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SelfW / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
        
        // MARK: roundRectanglePath 画矩形！
        [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(SelfW *0.2f, SelfH*0.35f, SelfW - SelfW*0.4f, SelfH - SelfH *0.7f) cornerRadius:0] bezierPathByReversingPath]];
        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = path.CGPath;
        
        [maskView.layer setMask:shapeLayer];
        
        //[self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        // 设置扫描范围
        // 注意，这个属性各个方向的取值范围为0-1，表示占layer层的长度比例，x对应的是距离左上角的垂直距离，y对应的是距离左上角的水平距离，w对应的是底部距离左上角的垂直距离，h对应的是最右边距离左上角的水平距离
        output.rectOfInterest = CGRectMake(0.35f, 0.2f, 0.7f, 0.8f);
        
        // 设置扫描框
        scanBox = [[UIView alloc]initWithFrame:CGRectMake(SelfW *0.2f, SelfH*0.35f, SelfW - SelfW*0.4f, SelfH - SelfH *0.7f)];
        
        scanBox.layer.borderColor = [UIColor greenColor].CGColor;
        scanBox.layer.borderWidth = 1.0f;
        [self addSubview:scanBox];
        
        
        // 扫描线
        scanLayer = [[CAGradientLayer alloc]init];
        scanLayer.frame = CGRectMake(0, 0, scanBox.bounds.size.width, ScanLineH);
        [scanBox.layer addSublayer:scanLayer];
        // 设置渐变颜色方向
        scanLayer.startPoint = CGPointMake(0, 0);
        scanLayer.endPoint = CGPointMake(0, 1);
        // 设定颜色组
        scanLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor brownColor].CGColor];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
        [timer fire];
        // 开始捕获
        [session startRunning];
        
    }
    
    
    return self;
}

// 以上之后我们的UI上已经可以看到摄像头捕获的内容，只要实现代理中的方法，就可以完成二维码条形码的扫描：
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        [session stopRunning];
        //输出扫描字符串
        if (self.onSuccess) {
            self.onSuccess(metadataObject.stringValue);
        }
        //NSLog(@"%@",metadataObject.stringValue);
        [scanLayer removeFromSuperlayer];
    }
}

// 实现计时器方法moveScanLayer:

- (void)moveScanLayer:(NSTimer *)timer {
    CGRect frame = scanLayer.frame;
    if (scanBox.frame.size.height < (scanLayer.frame.origin.y+ScanLineH + 5)) {
        frame.origin.y = -5;
        scanLayer.frame = frame;
    }
    else {
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            scanLayer.frame = frame;
        }];
    }
}

@end
