//
//  ViewController.m
//  顶部视图放大
//
//  Created by autobot on 17/1/11.
//  Copyright © 2017年 autobot. All rights reserved.
//

#import "ViewController.h"
#import "HeaderVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pushAction:(id)sender {
    [self.navigationController pushViewController:[[HeaderVC alloc]init]animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
