//
//  ViewController.h
//  iUPB-Lite
//
//  Created by Dirk Schumacher on 24.08.12.
//  Copyright (c) 2012 Dirk Schumacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>
{
    NSTimer *timer;
}
@property (nonatomic, retain) IBOutlet UIImageView *splash;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@end
