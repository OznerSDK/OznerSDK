# OznerSDK
## OznerSDK使用说明文档（iOS）
1. 下载项目,解压,将FrameWork添加到对应项目中

2. 项目初始化

    ```
    #import <Oznerlibrary/OznerManager.h>
    //初始化存储设备信息的本地数据库
    OznerManager* deviceDB= [[OznerManager alloc]init];
    [deviceDB setOwner:@"17621050877"];//当前登陆用户的用户id（可为手机号等等）
    ```

3. 设备配对相关信息
    * 初始化

    ```
#import <Oznerlibrary/MXChipPair.h>
#import <Oznerlibrary/Helper.h>
#import <Oznerlibrary/OznerManager.h>      
     
  pair=[[MXChipPair alloc] init];//初始化
  pair.delegate=self;（MxChipPairDelegate）//设置代理
    ```
    * 开始配对

    ```
    [pair start:ssid Password:pwd];
    ```
    
    * 取消配对
    
    ```
    
     [pair cancel];//配对超时时间可自行设置
    ```
        

4. 本地设备相关信息

* 获取本地所有设备
    
    ```
    [[OznerManager instance] getDevices];
    ```
* 删除本地配对设备

    ```
    
    [[OznerManager instance] remove:device];
    ```
5. 设备相关可获取以及可操作信息

    请参考Demo（AirViewController）
    
***
详细信息请参考OznerAirDemo



   
  
