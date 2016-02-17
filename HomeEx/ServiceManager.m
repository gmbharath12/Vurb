//
//  ServiceManager.m
//  HomeEx
//
//  Created by Bharath G M on 2/3/16.
//  Copyright © 2016 -. All rights reserved.
//

#import "ServiceManager.h"
#import "AppDelegate.h"
#import "Card.h"
#import "MovieCard.h"
#import "MusicCard.h"
#import "PlaceCard.h"

NSString *const cardURL = @"https://gist.githubusercontent.com/helloandrewpark/0a407d7c681b833d6b49/raw/5f3936dd524d32ed03953f616e19740bba920bcd/gistfile1.js";

@implementation ServiceManager

//The class is responsible for fetching the data from the server and parsing it
//We can design this class extensibly but for current scope

+(void)requestCardData:(ServiceCompletionBlock)completionBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSData *cardData = nil;
    NSError *error = nil;
    NSArray *dataArray = nil;
    cardData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cardURL]];
    if (!cardData)
    {
        error = [NSError errorWithDomain:@"Error"
                                    code:100
                                userInfo:@{
                                           NSLocalizedDescriptionKey:@"Something went wrong"}];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:cardData options:NSJSONReadingMutableContainers error:nil];
        
        dataArray = [ServiceManager parseJsonObject:jsonObjects];
    }
    
    completionBlock(dataArray, error);
}

+ (NSArray *)parseJsonObject:(id)cards
{
    
    NSMutableArray *dataArray = [NSMutableArray new];
    for (id cardObject in [cards valueForKey:@"cards"])
    {
        if ([[cardObject valueForKey:@"type"] isEqualToString:@"place"])
        {
            PlaceCard *card  = [[PlaceCard alloc] init];
            card.title = [cardObject valueForKey:@"title"];
            card.image = [cardObject valueForKey:@"imageURL"];
            card.placeCategory = [cardObject valueForKey:@"placeCategory"];
            card.type = CardTypePlace;
            [dataArray addObject:card];
        }
        else if ([[cardObject valueForKey:@"type"] isEqualToString:@"movie"])
        {
            MovieCard *card  = [[MovieCard alloc] init];
            card.title = [cardObject valueForKey:@"title"];
            card.image = [cardObject valueForKey:@"imageURL"];
            card.movieImageURL = [cardObject valueForKey:@"movieExtraImageURL"];
            card.type = CardTypeMovie;
            [dataArray addObject:card];
        }
        else if ([[cardObject valueForKey:@"type"] isEqualToString:@"music"])
        {
            MusicCard *card  = [[MusicCard alloc] init];
            card.title = [cardObject valueForKey:@"title"];
            card.image = [cardObject valueForKey:@"imageURL"];
            card.musicVideoURL = [cardObject valueForKey:@"musicVideoURL"];
            card.type = CardTypeMusic;
            [dataArray addObject:card];
        }
    }
    return dataArray;
}
    


@end
