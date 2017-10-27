//
//  AirViewController.m
//  OznerAirDemo
//
//  Created by 赵兵 on 2017/8/21.
//  Copyright © 2017年 赵兵. All rights reserved.
//

#import "AirViewController.h"
#import "AnimatedGIFImageSerialization.h"
@interface AirViewController ()
@property (strong, nonatomic) IBOutlet UILabel *deviceNameLB;
@property (strong, nonatomic) IBOutlet UIImageView *gifImageView;
@property (strong, nonatomic) IBOutlet UILabel *PM25SateLB;
@property (strong, nonatomic) IBOutlet UILabel *PM25LB;
@property (strong, nonatomic) IBOutlet UILabel *VOCLB;
@property (strong, nonatomic) IBOutlet UILabel *TemprateLB;
@property (strong, nonatomic) IBOutlet UILabel *HumidityLB;
@property (strong, nonatomic) IBOutlet UIImageView *LvXinImg;
@property (strong, nonatomic) IBOutlet UILabel *LvXinLB;
@property (strong, nonatomic) IBOutlet UILabel *PowerStateLB;
@property (strong, nonatomic) IBOutlet UIButton *PowerButton;
@property (strong, nonatomic) IBOutlet UILabel *SpeedStateLB;
@property (strong, nonatomic) IBOutlet UIButton *SpeedButton;
@property (strong, nonatomic) IBOutlet UILabel *LockStateLB;
@property (strong, nonatomic) IBOutlet UIButton *LockButton;

@end

@implementation AirViewController
-(void)setAir:(AirPurifier_MxChip *)air
{
    _air=air;
    _air.delegate=self;
    [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:false];
}

- (IBAction)menuClick:(id)sender {
    [self.navigationController popViewControllerAnimated:false];
}
- (IBAction)Setting:(id)sender {
}
- (IBAction)switchClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [_air.status setPower:!_air.status.power Callback:^(NSError *error) {
            }];
            break;
        case 1:
           
            
            switch (_air.status.getSpeed) {
                case 0:
                    [_air.status setSpeed:5 Callback:^(NSError *error) {
                    }];
                    break;
                case 5:
                    [_air.status setSpeed:4 Callback:^(NSError *error) {
                    }];
                    break;
                case 4:
                    [_air.status setSpeed:0 Callback:^(NSError *error) {
                    }];
                    break;
                default:
                    [_air.status setSpeed:0 Callback:^(NSError *error) {
                    }];
                    break;
            }
            
            break;
        case 2:
            [_air.status setLock:!_air.status.lock Callback:^(NSError *error) {
            }];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self deviceNameLB] setText:_air.settings.name];
    [self setGifImage:@"Airgif_blue.gif"];
    [[[self navigationController] navigationBar] setHidden:true];
}
-(void)setGifImage:(NSString*)name
{
    _gifImageView.image=[UIImage imageNamed:name];
}


-(void)update{
    _PM25LB.text=[[NSString alloc]initWithFormat:@"%d",[_air.sensor getPM25]];
    switch (_air.sensor.getVOC) {
        case 0:
            _VOCLB.text=@"优";
            break;
        case 1:
            _VOCLB.text=@"良";
            break;
        case 2:
            _VOCLB.text=@"一般";
            break;
        case 3:
            _VOCLB.text=@"差";
            break;
        default:
            _VOCLB.text=@"-";
            break;
            
    }
    _TemprateLB.text=[[NSString alloc]initWithFormat:@"%d℃",_air.sensor.getTemperature];
    _HumidityLB.text=[[NSString alloc]initWithFormat:@"%d%%",_air.sensor.getHumidity];
    
    [_PowerButton setImage:[UIImage imageNamed:(_air.status.power? @"air01001":@"air22011")] forState:UIControlStateNormal];
    _PowerStateLB.text=_air.status.power? @"开":@"关";
    if (!_air.status.power) {
        [_SpeedButton setImage:[UIImage imageNamed:@"air22012"] forState:UIControlStateNormal];
        [_LockButton setImage:[UIImage imageNamed:@"air22014"] forState:UIControlStateNormal];
        _SpeedStateLB.text=@"关";
        return;
    }
    switch (_air.status.speed) {
        case 0:
            [_SpeedButton setImage:[UIImage imageNamed:@"air01002"] forState:UIControlStateNormal];
            break;
        case 4:
            [_SpeedButton setImage:[UIImage imageNamed:@"airnightOn"] forState:UIControlStateNormal];
            break;
        default:
            [_SpeedButton setImage:[UIImage imageNamed:@"airdayOn"] forState:UIControlStateNormal];
            break;
    }
    
    [_LockButton setImage:[UIImage imageNamed:(_air.status.lock? @"air01004":@"air22014")] forState:UIControlStateNormal];
    _SpeedStateLB.text=_air.status.lock? @"开":@"关";
}
//OznerDeviceDelegate
-(void)OznerDeviceSensorUpdate:(OznerDevice *)device
{
    [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:false];
}

-(void)OznerDeviceStatusUpdate:(OznerDevice *)device
{
    [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:false];
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
