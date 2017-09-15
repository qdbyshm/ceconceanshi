//
//  LocalData.h
//  SMZDM
//
//  Created by 冯展波 on 14-7-17.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface LocalData : NSObject
{
    FMDatabase *fmDatabase;
}
@property (nonatomic,retain)FMDatabase *fmDatabase;

- (void)openSqlite;

- (FMDatabase *)getDb;
@end
