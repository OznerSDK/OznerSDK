//
//  AddDeviceViewController.h
//  OznerDemo_Air
//
//  Created by 赵兵 on 2017/8/21.
//  Copyright © 2017年 赵兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Oznerlibrary/MXChipPair.h>
#import <Oznerlibrary/Helper.h>
#import <Oznerlibrary/OznerManager.h>

@interface AddDeviceViewController : UIViewController<MxChipPairDelegate,UITextFieldDelegate>
{
    NSDate* startTime;
    MXChipPair* pair;
    MXChipIO* foundIO;
}
@end
