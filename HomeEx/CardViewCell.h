//
//  CardViewCell.h
//  HomeEx
//
//  Created by Bharath G M on 2/3/16.
//  Copyright © 2016 -. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@protocol CardViewCellProtocol <NSObject>

-(void)cellActionWithActionType:(CardType)type andIndexPath:(int)row;

@end


@interface CardViewCell : UITableViewCell

@property (nonatomic, strong)  UIImageView *thumbnailImageView;
@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UIButton *playBtn;
@property (nonatomic)CardType type;
@property (nonatomic, weak)id  <CardViewCellProtocol>delegate;

@end
