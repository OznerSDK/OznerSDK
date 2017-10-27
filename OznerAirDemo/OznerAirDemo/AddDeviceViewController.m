//
//  AddDeviceViewController.m
//  OznerDemo_Air
//
//  Created by 赵兵 on 2017/8/21.
//  Copyright © 2017年 赵兵. All rights reserved.
//

#import "AddDeviceViewController.h"

@interface AddDeviceViewController ()
@property (strong, nonatomic) IBOutlet UITextField *ssidTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextView *logTV;

@end

@implementation AddDeviceViewController
- (IBAction)starClick:(id)sender {
    NSString* ssid=self.ssidTF.text;
    NSString* pwd=self.passwordTF.text;
    if (StringIsNullOrEmpty(ssid))
    {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"错误"
                                                                     message:@"请输入SSID"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSUserDefaults* settings=[NSUserDefaults standardUserDefaults];
    [settings setObject:self.passwordTF.text forKey:[NSString stringWithFormat:@"SSID_%@",ssid]];
    [settings synchronize];
    startTime=[NSDate dateWithTimeIntervalSinceNow:0];
    [pair start:ssid Password:pwd];
    
}
- (IBAction)cancleClick:(id)sender {
    if (pair.isRuning)
    {
        [pair cancel];
    }
}
- (IBAction)OKClick:(id)sender {
    if (foundIO)
    {
        OznerDevice* device=[[OznerManager instance] getDeviceByIO:foundIO];
        [[OznerManager instance] save:device];
        [[self navigationController] popViewControllerAnimated:true];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pair=[[MXChipPair alloc] init];
    pair.delegate=self;
    NSString* ssid=[MXChipPair getWifiSSID];
    self.ssidTF.text=ssid;
    if (!StringIsNullOrEmpty(ssid))
    {
        NSUserDefaults* settings=[NSUserDefaults standardUserDefaults];
        NSString* pwd=[settings stringForKey:[NSString stringWithFormat:@"SSID_%@",ssid]];
        if (!StringIsNullOrEmpty(pwd))
        {
            self.passwordTF.text=pwd;
        }
    }
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (pair.isRuning)
    {
        [pair cancel];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)printLOG:(NSString *)str
{
    NSString* tmpStr=[NSString stringWithFormat:@"%@\n%@",_logTV.text,str];
    [_logTV setText:tmpStr];
}
-(void)IOComplete:(MXChipIO *)io
{
    if (io==nil) {
        [self printLOG:@"配网失败"];
        return;
    }
    foundIO=io;
    
    NSDate* date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSString* log=[NSString stringWithFormat:@"配网成功,耗时:%f秒",
                   [date timeIntervalSince1970]-[startTime timeIntervalSince1970]
                   ];
    [self printLOG:log];
    
    
    NSString* log1=[NSString stringWithFormat:@"Name:%@",io.name];
    NSString* log2=[NSString stringWithFormat:@"Type:%@",io.type];
    NSString* log3=[NSString stringWithFormat:@"MAC:%@",io.identifier];
    [self printLOG:log1];
    [self printLOG:log2];
    [self printLOG:log3];
    
}
//MxChipPairDelegate
-(void)mxChipComplete:(MXChipIO *)io
{
    [self performSelectorOnMainThread:@selector(IOComplete:) withObject:io waitUntilDone:false];
}
-(void)mxChipFailure
{
    [self performSelectorOnMainThread:@selector(printLOG:) withObject:@"配网失败" waitUntilDone:false];
}
-(void)mxChipPairActivate
{
    [self performSelectorOnMainThread:@selector(printLOG:) withObject:@"等待设备激活" waitUntilDone:false];
}
-(void)mxChipPairSendConfiguration
{
    [self performSelectorOnMainThread:@selector(printLOG:) withObject:@"正在发送配置信息" waitUntilDone:false];
}
-(void)mxChipPairWaitConnectWifi
{
    [self performSelectorOnMainThread:@selector(printLOG:) withObject:@"等待设备连接wifi"waitUntilDone:false];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
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
