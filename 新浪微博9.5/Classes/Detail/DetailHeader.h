//
//  DetailHeader.h
//  新浪微博9.5
//
//  Created by homeboy on 14-10-11.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface DetailHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *attitude;
@property (weak, nonatomic) IBOutlet UIImageView *hint;
- (IBAction)btnClick:(UIButton *)sender;
+(id)header;

@property (nonatomic,strong)Status *status;
@end
