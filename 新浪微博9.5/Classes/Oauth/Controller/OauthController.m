//
//  OauthController.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-16.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//
#define kAppKey @"431315585"
#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret @"53919843fa900956260731bf1e99d6db"
#define kOauthrize @"https://api.weibo.com/oauth2/authorize"

#import "OauthController.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "MainController.h"
#import "MBProgressHUD.h" 
@interface OauthController ()<UIWebViewDelegate>
{
    UIWebView *webView;
}
@end

@implementation OauthController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = webView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //OAUTH授权
    NSString *urlStr = [kOauthrize stringByAppendingFormat:@"?display=mobile&client_id=%@&redirect_uri=%@",kAppKey,kRedirectURI];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    //设置代理
    webView.delegate = self;
}
#pragma mark - 当webView开始加载请求就会调用 
- (void)webViewDidStartLoad:(UIWebView *)webView
{
 //显示指示器
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在处理信息中...";
    hud.dimBackground = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];  
}
#pragma mark webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    //获得全路径
    NSString *urlString = request.URL.absoluteString;
    //查找code=的范围
    NSRange  range = [urlString rangeOfString:@"code="];
      
    if (range.length != 0) {
        //跳到回调地址,说明已经授权成功
        int index = range.location + range.length;
        NSString *requestToken = [urlString substringFromIndex:index];
        NSLog(@"%@",requestToken);
        //换取AccessToken
        [self getAccessToken:requestToken];
        return YES;
    }
    return YES;
}
- (void)getAccessToken:(NSString *)requestToken
{
    [HttpTool postWithBaseURL:@"https://api.weibo.com" path:@"oauth2/access_token" params:@{@"client_id":kAppKey,@"client_secret":kAppSecret,@"grant_type":@"authorization_code",@"code":requestToken,@"redirect_uri":kRedirectURI} succcess:^(id JSON) {
        NSLog(@"请求成功--%@",JSON);
        //---------保存账号信息-----------------
        Account *account = [[Account alloc]init];
        account.accessToken = JSON[@"access_token"];
        account.uid = JSON[@"uid"];
        [[AccountTool shareAccountTool] saveAccount:account];
        //回到主页面
        self.view.window.rootViewController =  [[MainController alloc]init];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    //创建post请求    ------1--------
//        AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com"]];
//
//        NSURLRequest *post = [client requestWithMethod:@"POST" path:@"oauth2/access_token"  parameters:@{@"client_id":kAppKey,@"client_secret":kAppSecret,@"grant_type":@"authorization_code",@"code":requestToken,@"redirect_uri":kRedirectURI}];
    //  ------------------2---------------------
//    NSMutableURLRequest *post = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
//    post.HTTPMethod = @"POST";
//    NSString *param =[NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",kAppKey,kAppSecret,requestToken,kRedirectURI];
//    post.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    //发送post请求
//    NSOperation *op = [AFJSONRequestOperation  JSONRequestOperationWithRequest:post
//    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                        NSLog(@"请求成功--%@",JSON);
//        //---------保存账号信息-----------------
//                Account *account = [[Account alloc]init];
//    account.accessToken = JSON[@"access_token"];
//    account.uid = JSON[@"uid"];
//    [[AccountTool shareAccountTool] saveAccount:account];
//    //回到主页面
//    self.view.window .rootViewController =  [[MainController alloc]init];
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }
//    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                NSLog(@"请求失败");
//     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }];
   
    //发送请求
//    [op start];
}
@end