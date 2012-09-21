//
//  ViewController.m
//  iUPB-Lite
//
//  Created by Dirk Schumacher on 24.08.12.
//  Copyright (c) 2012 Dirk Schumacher. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

//thanks: http://www.iphonedevsdk.com/forum/business-legal-app-store/107812-so-how-do-we-deal-with-dimensions-of-existing-apps-re-iphone-5.html
#define IS_SHORT_IPHONE()	([UIScreen mainScreen].bounds.size.height == 480)
#define IS_TALL_IPHONE()	([UIScreen mainScreen].bounds.size.height == 568)

@implementation ViewController
@synthesize webView;
@synthesize splash;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //timout
    float timeout = 40.0f;
    
    NSString *urlAddress = @"http://www.i-upb.de/de";
        
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:timeout];
        
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"failed to connect");
    [self askToCloseApp];
}
- (void) askToCloseApp {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Keine Verbindung" message:@"Vielleicht kein Internet?" delegate:self cancelButtonTitle:@"App schließen" otherButtonTitles:@"Nochmal laden", nil];
    [alert show];
    [alert release];
    if (timer) {
        [timer invalidate];
    }
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
         exit(0);
    }else {
        [webView reload];
    }
}
- (void)cancelWeb
{
    NSLog(@"Cancel web");
   [self askToCloseApp];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [webView release];
    [splash release];

}
-(void) viewWillAppear:(BOOL) animated {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.view.userInteractionEnabled = NO;
        [self setSplashScreenImage];
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(orientationChanged:)
                                                         name:UIDeviceOrientationDidChangeNotification
                                                       object:nil];
            
        }
    });
}
- (void)orientationChanged:(NSNotification *)notification
{
    if (![self.splash isHidden])
        [self setSplashScreenImage];
}
-(void) setSplashScreenImage {
<<<<<<< HEAD
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && IS_SHORT_IPHONE() ){
        //[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
        splash.image = [UIImage imageNamed:@"Default.png"];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && IS_TALL_IPHONE()){
        //[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
        splash.image = [UIImage imageNamed:@"Default-568h.png"];
    }
=======
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        //[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
        splash.image = [UIImage imageNamed:@"Default.png"];
    }
>>>>>>> 9abe4870f8154e0788d9128c21df15bcdf4fd082
    else {
        if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]) )
            splash.image = [UIImage imageNamed:@"Default-Portrait.png"];
        else
            splash.image = [UIImage imageNamed:@"Default-Landscape.png"];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && ![self.splash isHidden]){
        return orientation == UIInterfaceOrientationPortrait;
    }
    return YES;
}
-(void) webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //timer = [NSTimer scheduledTimerWithTimeInterval:40.0 target:self selector:@selector(cancelWeb) userInfo:nil repeats:NO];
}
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.splash removeFromSuperview];
        [self.splash setHidden:YES];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
        }

        self.view.userInteractionEnabled = YES;
    });
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //[timer invalidate];
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    NSRange range = [[[inRequest URL] absoluteString] rangeOfString:@"www.i-upb.de"
                                      options:NSCaseInsensitiveSearch];
    if ( inType == UIWebViewNavigationTypeLinkClicked && range.location == NSNotFound) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
