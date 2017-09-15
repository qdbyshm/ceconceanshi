//
//  Desencryption.h
//  SMZDM
//
//  Created by shm on 13-6-15.
//
//

#import <Foundation/Foundation.h>
#define THEDESKEY @"8b5eav1g"
@interface Desencryption : NSObject
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
//+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
+(NSString *) encryptUseDES2:(NSString *)sText key:(NSString *)key;
@end
