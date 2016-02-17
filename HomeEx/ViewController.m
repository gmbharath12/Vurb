//
//  ViewController.m
//  HomeEx
//
//  Created by Bharath G M on 2/3/16.
//  Copyright © 2016 -. All rights reserved.
//

#import "ViewController.h"
#import "CardViewCell.h"
#import "Card.h"
#import "MovieCard.h"
#import "MusicCard.h"
#import "PlaceCard.h"
#import "UIImageView+AFNetworking.h"
#import "ServiceManager.h"
#import "UIImage+AverageColor.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+ProportionalFill.h"

#define kRowHeight 100

@interface ViewController ()<CardViewCellProtocol>

@property (nonatomic, strong) UITableView *cardsTableView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Cards";
    [self fetchData];
    [self setUpTableView];
}

#pragma Create TableView

- (void)setUpTableView
{
    self.dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.cardsTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.cardsTableView.delegate = self;
    self.cardsTableView.dataSource = self;
    self.cardsTableView.backgroundColor = [UIColor clearColor];
    [self.cardsTableView registerClass:[CardViewCell class] forCellReuseIdentifier:@"CardCell"];
    self.cardsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.cardsTableView];

}

#pragma mark Fetch Data

- (void) fetchData
{
    [ServiceManager requestCardData:^(NSArray *cardData, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self showAlertView:[error localizedDescription]];
            } else {
                 self.dataArray = cardData;
                [self.cardsTableView reloadData];
            }
        });
    }];

}

#pragma Alert View
- (void)showAlertView:(NSString *)string
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@""
                                                                    message:string                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.dataArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardViewCell *cell = (CardViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CardCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    Card *card = self.dataArray[indexPath.row];
    if (card) {
        cell.tag = indexPath.row;
        cell.type = card.type;
        cell.titleLabel.text  = card.title;
        cell.playBtn.hidden = (card.type == CardTypeMusic)? false:true;
        [self downloadImageForCell:cell andWithCard:card];
    }

    return cell;
}

-(void)cellActionWithActionType:(CardType)actionType andIndexPath:(int)row
{
    Card *card = nil;
    switch (actionType) {
        case CardTypeMovie:
            break;
        case CardTypeMusic:
            card = self.dataArray[row];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: ((MusicCard *)card).musicVideoURL]];
            break;
        case CardTypePlace:
            break;
        default:
            break;
    }

}

-(void)downloadImageForCell:(CardViewCell *)cell andWithCard:(Card *)card
{
    NSString *imageURL = (card.type == CardTypeMovie) ? ((MovieCard *)card).movieImageURL : card.image;;
    [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                               placeholderImage:[UIImage imageNamed:@"imagePlaceholder"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   if (card.type == CardTypePlace) {
                                       if (image != nil) {
                                           [cell.imageView.image imageScaledToFitSize:cell.imageView.frame.size];
                                           cell.backgroundColor = image.averageColor;
                                       }
                                   }
                               }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
