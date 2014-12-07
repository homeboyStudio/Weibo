//
//  GroupCell.h
//  新浪微博9.5
//
//  Created by homeboy on 14-9-15.
//  Copyright (c) 2014年 com.homeboy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kCellTypeNore,
    kCellTypeArrow,
    kCellTypeLabel
}CellType;
@interface GroupCell : UITableViewCell
@property (nonatomic,readonly)UILabel *rightLabel;
@property (nonatomic,assign)CellType cellType;
@property (nonatomic,weak)UITableView *myTableView;
@property (nonatomic,strong)NSIndexPath *indexPath;
@end
