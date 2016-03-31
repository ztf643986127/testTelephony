//
//  ViewController.m
//  testTelephony
//
//  Created by 赵腾飞 on 16/3/31.
//  Copyright © 2016年 赵腾飞. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@interface ViewController (){
    UILabel *infoLabel;
    UILabel *serverLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(240, 100, 100, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"获取网络环境" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(220, 150, 150, 40);
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"获取运营商名称" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    infoLabel = [[UILabel alloc]init];
    infoLabel.frame = CGRectMake(20, 100, 200, 30);
    infoLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:infoLabel];
    serverLabel = [[UILabel alloc]init];
    serverLabel.frame = CGRectMake(20, 150, 200, 30);
    serverLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:serverLabel];
    
    
}

- (void)click{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            NSLog(@"No wifi or cellular");
            infoLabel.text=@"无服务";
            break;
            
        case 1:
            NSLog(@"2G");
            infoLabel.text=@"2G";
            break;
            
        case 2:
            NSLog(@"3G");
            infoLabel.text=@"3G";
            break;
            
        case 3:
            NSLog(@"4G");
            infoLabel.text=@"4G";
            break;
            
        case 4:
            NSLog(@"LTE");
            infoLabel.text=@"LTE";
            break;
            
        case 5:
            NSLog(@"Wifi");
            infoLabel.text=@"Wifi";
            break;
            
            
        default:
        break;
    }
}

- (void)click2{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
    serverLabel.text=currentCountry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
