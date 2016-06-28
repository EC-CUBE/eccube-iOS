//
//  WebViewController.m
//  EcCubeSample
//

#import "WebViewController.h"

static NSString *const kDefaultStartUrl = @"http://example.com";

@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:kDefaultStartUrl];
    if (self.initialPath != nil){
        url = [url URLByAppendingPathComponent:self.initialPath];
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate
-  (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //for debug
    NSLog(@"%@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);

    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    //ログインフォームにhidden tagを埋める部分
    NSInteger formCount = [[webView stringByEvaluatingJavaScriptFromString:@"document.forms.length"] integerValue];
    for (int i = 0; i < formCount; i++) {
        NSString *action = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.forms[%@].action", @(i)]];
        if ([action hasSuffix:@"login_check"]){
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *devTokenString = [userDefaults stringForKey:@"deviceToken"];

            NSString *js = [NSString stringWithFormat:@""
                "var idq = document.createElement('input');"
                "idq.type = 'hidden';"
                "idq.name = 'login_device_id';"
                "idq.value = '%@';"
                "document.forms[%@].appendChild(idq);"
                "var osq = document.createElement('input');"
                "osq.type = 'hidden';"
                "osq.name = 'login_os';"
                "osq.value = 'ios';"
                "document.forms[%@].appendChild(osq);"
                "", devTokenString?:@"", @(i), @(i)];
            [webView stringByEvaluatingJavaScriptFromString:js];
        }
    }
}

@end
