//
//  ViewController.m
//  OznerDemo_Air
//
//  Created by 赵兵 on 2017/8/21.
//  Copyright © 2017年 赵兵. All rights reserved.
//

#import "DeviceTableController.h"
#import "AirViewController.h"

@interface DeviceTableController ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation DeviceTableController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //testClass* testVC=[[testClass alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self update];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self navigationController] navigationBar] setHidden:false];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)update
{
    self->devices=[[OznerManager instance] getDevices];
    [self.tableview reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self->devices count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceTableCell" forIndexPath:indexPath];
    OznerDevice *device=[devices objectAtIndex:indexPath.row];
    [cell.textLabel setNumberOfLines:0];
    NSString* textStr=[NSString stringWithFormat:@"name:%@\nmac:%@",device.settings.name,device.identifier];
    [cell.textLabel setText:textStr];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        OznerDevice* device=[devices objectAtIndex:indexPath.item];
        [[OznerManager instance] remove:device];
        [self update];
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete	;
}
-(BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath
{
    return false;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //OznerDevice *device=[devices objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showAirMain" sender:indexPath];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"showAirMain"]) {
         AirViewController* airVC=(AirViewController*)segue.destinationViewController;
         airVC.air=[devices objectAtIndex:((NSIndexPath *)sender).row];
     }
 }

@end
