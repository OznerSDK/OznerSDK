//
//  AirViewController.h
//  OznerAirDemo
//
//  Created by 赵兵 on 2017/8/21.
//  Copyright © 2017年 赵兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Oznerlibrary/AirPurifier_MxChip.h>
#import <Oznerlibrary/OznerManager.h>
@interface AirViewController : UIViewController<OznerDeviceDelegate>
@property (weak,nonatomic) AirPurifier_MxChip* air;
@end
