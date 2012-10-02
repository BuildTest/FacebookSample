//
//  ViewController.m
//  Facebook1
//
//  Created by Nghia on 10/1/12.
//  Copyright (c) 2012 Nghia. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@property(strong,nonatomic) IBOutlet UIButton *buttonLoginLogout;
@property(strong ,nonatomic) IBOutlet UITextView *text;

-(IBAction)buttonclick:(id)sender;
-(void)updateView;

@end

@implementation ViewController
@synthesize buttonLoginLogout,text;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
    
    
    AppDelegate *appdelegate=[UIApplication sharedApplication].delegate;
    if (!appdelegate.session.isOpen) {
        appdelegate.session=[[FBSession alloc]init];
        if (appdelegate.session.state==FBSessionStateCreatedTokenLoaded) {
            [appdelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                [self updateView];
            }];
        }
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)buttonclick:(id)sender{
    NSLog(@"button click");
    AppDelegate *appdelegate=[UIApplication sharedApplication].delegate;
    if (appdelegate.session.isOpen) {
        NSLog(@"session is opened");
        [appdelegate.session closeAndClearTokenInformation ];
        
    }
    else{
        NSLog(@"session is not open");
        AppDelegate *appdelegate=[UIApplication sharedApplication].delegate;
        if (appdelegate.session.state!=FBSessionStateCreated) {
            NSLog(@"if session is not created ,create");
            appdelegate.session = [[FBSession alloc] init];
        }
        [appdelegate.session openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [self updateView];
        }];
    }
}
-(void)updateView{
    NSLog(@"updateView");
    AppDelegate *appdelegate=[[UIApplication sharedApplication]delegate];
    if (appdelegate.session.isOpen) {
        NSLog(@"da login voi access token la %@",appdelegate.session.accessToken);
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [self.text setText:[NSString stringWithFormat:@"access token la : %@",appdelegate.session.accessToken]];
    }
    else{
        NSLog(@"Chua login");
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
        [self.text setText:[NSString stringWithFormat:@"Chua dang nhap , click button de dang nhap"]];
    }
}


-(void)dealloc{
    [super dealloc];
  
}
@end
