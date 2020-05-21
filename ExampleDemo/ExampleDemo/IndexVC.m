//
//  IndexVC.m
//  ExampleDemo
//
//  Created by 李罗坚 on 2020/5/21.
//  Copyright © 2020 李罗坚. All rights reserved.
//

#import "IndexVC.h"
#import "HHLocalAut.h"
#import "HHAlert.h"
@interface IndexVC ()
@property (weak, nonatomic) IBOutlet UIButton *reBtn;
@end

@implementation IndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BiometryTyle type = [[[HHLocalAut alloc] init] getSupportType];
    [self.reBtn setImage:[UIImage imageNamed:type==biometryTyleFaceID?@"面容ID":type==biometryTyleTouchID?@"指纹ID":@""] forState:UIControlStateNormal];
}

#pragma mark - user Actions
- (IBAction)reBtnAction:(UIButton *)sender {
    [[[HHLocalAut alloc] init] evaluatePolicy:^(BOOL success, LAError error, NSString * _Nonnull reason) {
        [[HHAlert alert:nil title:@"提示" message:reason confirm:@"好的" confirmBlock:^(HHAlert * _Nonnull alert) {
            
        }] show];
    }];
}
@end
