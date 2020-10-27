//
//  ViewController.m
//  NSResultKitExample
//
//  Created by Robert Armenski on 27.10.20.
//

#import "ViewController.h"
#import "NSResultKitExample-Swift.h"
@import NSResultKit;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Helper process:[NSResult success:@"Success"]];
    [Helper process:[NSResult failure:[NSError errorWithDomain:@"NSResultKitExampleErrorDomain"
                                                          code:666
                                                      userInfo:nil]]];
}

- (IBAction)roll:(id)sender {
    NSResult *result = [Helper randomResult];
    [result performSuccess:^(id _Nonnull value) {
        [_resultLabel setText:[NSString stringWithFormat:@"Success: %@", value]];
    } orFailure:^(NSError * _Nonnull error) {
        [_resultLabel setText:[NSString stringWithFormat:@"Failure: %@", [error localizedDescription]]];
    }];
}

@end
