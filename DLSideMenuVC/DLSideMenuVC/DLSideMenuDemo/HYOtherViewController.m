//
//  HYOtherViewController.m
//  HYKD
//
//  Created by Edward on 16/3/24.
//  Copyright © 2016年 com.huayikangdao. All rights reserved.
//

#import "HYOtherViewController.h"
#import <AFNetworking.h>


@interface HYOtherViewController ()
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@end

@implementation HYOtherViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//如果报接受类型不一致请替换一致text/html或别的
//        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"application/x-javascript",nil];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.view.userInteractionEnabled = NO;
    
//    NSLog(@"父控制器%@",self.navigationController);
    
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"did"] = @"888888";
    params[@"onlinestatus"] = @1;
 
    
    // 发送请求
    [self.manager GET:@"http://192.168.1.169:8080/yijiabao/api/user/addDevicesOnlineStatus" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
//    [self.manager GET:@"http://192.168.1.169:8080/yijiabao/api/user/addDevicesOnlineStatus" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@",responseObject);
//        
//      
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//     NSLog(@"%@",error);
//    }];


    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
