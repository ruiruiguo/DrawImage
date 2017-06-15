//
//  ViewController.m
//  image
//
//  Created by xinshang on 2017/6/15.
//  Copyright © 2017年 xinshang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imgView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *myImage1 = [UIImage imageNamed:@"map_zhanling@2x"];
//   .获取网络图片
    UIImage *myImage2 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.kutx.cn/xiaotupian/icons/png/200803/20080327095245737.png"]]];
//   .加载本地图片
//    UIImage *myImage2 =[UIImage imageNamed:@"水果大战"];
    
//    .在图片上绘制文字
//    UIImage *changeImage = [self createShareImage:myImage1 Context:@"Hello"];
//    .在图片上绘制图片
    UIImage *changeImage = [self createShareImage:myImage1 ContextImage:myImage2];
    
    imgView = [[UIImageView alloc] initWithImage:changeImage];
    imgView.frame = CGRectMake(100, 100, 100, 100);
    imgView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:imgView];
    
}


// 1.将文字添加到图片上;imageName 图片名字， text 需画的字体
- (UIImage *)createShareImage:(UIImage *)tImage Context:(NSString *)text
{
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    CGFloat nameFont = 8.f;
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    NSLog(@"图片: %f %f",imageSize.width,imageSize.height);
    NSLog(@"sizeToFit: %f %f",sizeToFit.size.width,sizeToFit.size.height);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [text drawAtPoint:CGPointMake((imageSize.width-sizeToFit.size.width)/2,0) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]}];
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


// 2.在图片上添加图片;imageName 1.底部图片名字imageName， image2 需添加的图片
- (UIImage *)createShareImage:(UIImage *)tImage ContextImage:(UIImage *)image2
{
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //画 自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);

    CGRect rect = CGRectMake( imageSize.width/4,imageSize.height/5, imageSize.width/2, imageSize.height/2);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image2 drawInRect:rect];
    
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


@end
