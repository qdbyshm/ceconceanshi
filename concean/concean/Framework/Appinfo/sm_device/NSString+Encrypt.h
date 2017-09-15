//
//  NSString+Encrypt.h
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/2.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

- (NSString *)encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;
- (NSString *)decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

- (NSString *)encryptedWith3DESUsingKey:(NSString *)key andIV:(NSData *)iv;
- (NSString *)decryptedWith3DESUsingKey:(NSString *)key andIV:(NSData *)iv;

@end
