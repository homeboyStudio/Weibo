//
//  GroupCell.m
//  新浪微博9.5
//
//  Created by homeboy on 14-9-15.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import "GroupCell.h"
#import "UIImage+HomeboyAdd.h"
@interface GroupCell()
{
    UIImageView *_bg;
    UIImageView *_selecttedBg;
}
@end
@implementation GroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置cell背景,性能优化
        self.textLabel.backgroundColor = [UIColor clearColor];
        _bg = [[UIImageView alloc]init];
        self.backgroundView = _bg;
        _selecttedBg = [[UIImageView alloc]init];
        self.selectedBackgroundView = _selecttedBg;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.highlightedTextColor = [UIColor blackColor];

    }
    return self;
}
- (void)setCellType:(CellType)cellType
{
    _cellType = cellType;
    if (cellType == kCellTypeArrow) {
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
else if(cellType == kCellTypeLabel){
        UILabel *label = [[UILabel alloc]init];
        label.bounds = CGRectMake(0, 0, 80, 44);
        //清除背景
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        self.accessoryView = label;
    _rightLabel = label;
    }else if (cellType == kCellTypeNore){
        self.accessoryView = nil;
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger count = [_myTableView numberOfRowsInSection:indexPath.section];
    _indexPath = indexPath;
    if (count == 1) {
        _bg.image = [UIImage resizedImage:@"common_card_background"];
        _selecttedBg.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    }else if(indexPath.row == 0) {
        _bg.image = [UIImage resizedImage:@"common_card_top_background"];
        _selecttedBg.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    }else if (indexPath.row == count - 1){
        _bg.image = [UIImage resizedImage:@"common_card_bottom_background"];
        _selecttedBg.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    }else{
        _bg.image = [UIImage resizedImage:@"common_card_middle_background"];
        _selecttedBg.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
        
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
