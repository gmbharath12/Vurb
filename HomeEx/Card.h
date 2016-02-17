//
//  Card.h
//  HomeEx
//
//  Created by Bharath G M on 2/3/16.
//  Copyright © 2016 -. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"


typedef NS_ENUM(NSInteger, CardType) {
    CardTypeMovie ,
    CardTypeMusic,
    CardTypePlace
};


@interface Card : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) UIColor *averageColor;
@property (nonatomic)         CardType type;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
