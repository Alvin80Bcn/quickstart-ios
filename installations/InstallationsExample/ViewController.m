/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ViewController.h"

// TODO: Remove once FirebaseInstallations released.
#import <FirebaseInstallations/FIRInstallations.h>
#import <FirebaseInstallations/FIRInstallationsAuthTokenResult.h>

@import Firebase;

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *getInstallationButton;
@property (strong, nonatomic) IBOutlet UIButton *getAuthTokenButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteInstallationButton;
@property (strong, nonatomic) IBOutlet UITextView *logTextView;

@property(strong, nonatomic) NSString *log;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.log = @"";
}

- (FIRInstallations *)installations {
  // TODO: Replace by [FIRInstallations installations] when implemented.
  return [FIRInstallations installationsWithApp:[FIRApp defaultApp]];
}

- (IBAction)getInstallationButtonPressed {
  [self logMessage:@"Call [FIRInstallations installationIDWithCompletion:]"];
  [[self installations] installationIDWithCompletion:^(NSString * _Nullable identifier, NSError * _Nullable error) {
    NSString *message = [NSString stringWithFormat:@"[FIRInstallations installationIDWithCompletion:] result:\n identifier = %@\nerror = %@", identifier, error];
    [self logMessage:message];
  }];
}

- (IBAction)getAuthTokenButtonPressed {
  [self logMessage:@"Call [FIRInstallations authTokenWithCompletion:]"];
  [[self installations] authTokenWithCompletion:^(FIRInstallationsAuthTokenResult * _Nullable tokenResult, NSError * _Nullable error) {
    NSString *message = [NSString stringWithFormat:@"[FIRInstallations authTokenWithCompletion:] result:\n tokenResult.authToken = %@\ntokenResult.expirationDate%@\nerror = %@", tokenResult.authToken, tokenResult.expirationDate, error];
    [self logMessage:message];
  }];
}

- (IBAction)deleteInstallationButtonPressed {
  [self logMessage:@"Call [FIRInstallations deleteWithCompletion:]"];
  [[self installations] deleteWithCompletion:^(NSError *_Nullable error) {
    NSString *message = [NSString stringWithFormat:@"[FIRInstallations deleteWithCompletion:] result:\n %@",
                         error ?: @"SUCCESS"];
    [self logMessage:message];
  }];
}

#pragma mark - Log

- (void)setLog:(NSString *)log {
  _log = log;
  self.logTextView.text = log;
}

- (void)logMessage:(NSString *)message {
  NSString *logMessage = [NSString stringWithFormat:@"%@\n---\n", message];
  self.log = [logMessage stringByAppendingString:self.log];
}

@end