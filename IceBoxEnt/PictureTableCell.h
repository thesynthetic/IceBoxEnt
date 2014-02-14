//
//  PictureTableCell.h
//  IceBoxEnt
//
//  Created by Ryan Hittner on 11/11/13.
//  Copyright (c) 2013 Ryan Hittner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PictureTableCellDelegate <NSObject>
@optional
- (void)launchViewer:(NSString*)largeURL forIndex:(NSInteger)index;
@end

@interface PictureTableCell : UITableViewCell
{
    
}

@property (nonatomic, strong) IBOutlet UIImageView *image1;
@property (nonatomic, strong) IBOutlet UIImageView *image2;
@property (nonatomic, strong) IBOutlet UIImageView *image3;

@property (nonatomic, strong) IBOutlet UIButton *button1;
@property (nonatomic, strong) IBOutlet UIButton *button2;
@property (nonatomic, strong) IBOutlet UIButton *button3;

@property (nonatomic, strong) NSString *largeURL1;
@property (nonatomic, strong) NSString *largeURL2;
@property (nonatomic, strong) NSString *largeURL3;

@property (nonatomic) NSInteger indexBase;

@property (nonatomic, retain) id <PictureTableCellDelegate> delegate;

@end
