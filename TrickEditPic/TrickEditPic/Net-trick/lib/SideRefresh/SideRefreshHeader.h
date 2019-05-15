//
//  SideRefreshHeader.h
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "SideRefresh.h"

@interface SideRefreshHeader : SideRefresh

@end

@interface HYChangeableCell : UICollectionViewCell
@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, assign) BOOL isList;

@property (nonatomic, copy) NSString *imageName;
@end


@interface ViewController : UIViewController


@end
