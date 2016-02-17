//
//  CardViewCell.m
//  HomeEx
//
//  Created by Bharath G M on 2/3/16.
//  Copyright © 2016 -. All rights reserved.
//

#import "CardViewCell.h"

@interface CardViewCell ()

@end


@implementation CardViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        self.thumbnailImageView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.thumbnailImageView];

        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(80, 12, 224, 40)];
        [self.contentView addSubview:self.titleLabel];
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:[UIImage imageNamed:@"play_vdo"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.playBtn];
        [self.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)playAction:(UIButton *)sender
{
    
    if ([self.delegate conformsToProtocol:@protocol(CardViewCellProtocol)]) {
        [self.delegate cellActionWithActionType:self.type andIndexPath:(int)self.tag];
    }
    
   
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.thumbnailImageView.frame = CGRectMake(10,10,80,self.frame.size.height-20);
    self.titleLabel.frame = CGRectMake(self.thumbnailImageView.frame.origin.x+self.thumbnailImageView.frame.size.width+20, 10, self.frame.size.width-self.titleLabel.frame.origin.x, 40);
    [self.playBtn setFrame:CGRectMake(self.frame.size.width-self.thumbnailImageView.frame.size.width,
                                      self.titleLabel.frame.size.height+10, 44, 44)];
}






@end
