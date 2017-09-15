//
//  Desencryption.m
//  SMZDM
//
//  Created by shm on 13-6-15.
//
//

#import "Desencryption.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
static Byte iv[] = {1,2,3,4,5,6,7,8};

@implementation Desencryption
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    }
    return plainText;
}

//+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
// {
//    
//    NSString *ciphertext = nil;
//    
//       const char *textBytes = [plainText UTF8String];
//    NSUInteger dataLength = [plainText length];
//    
//      unsigned char buffer[1024];
//    
//     memset(buffer, 0, sizeof(char));
//    
//      size_t numBytesEncrypted = 0;
//    
//        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                                 
//                                                                                    kCCOptionPKCS7Padding,
//                                                 
//                                                                                     [key UTF8String], kCCKeySizeDES,
//                                                 
//                                                                                     iv,
//                                                 
//                                                                                    textBytes, dataLength,
//                                                 
//                                                                                buffer, 1024,
//                                                 
//                                                                                    &numBytesEncrypted);
//    
//     if (cryptStatus == kCCSuccess) {
//        
//            NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//        
//         ciphertext = [data base64Encoding];
//        
//     }
//    
//    return ciphertext;
//    
//}




+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
    
}
+(NSString *) encryptUseDES2:(NSString *)sText key:(NSString *)key
{
    const void *dataIn;
    size_t dataInLength;
    
    NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
    dataInLength = [encryptData length];
    dataIn = (const void *)[encryptData bytes];
    
    
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    NSString *initIv = @"12345678";
    const void *vkey = (const void *) [key UTF8String];
    const void *iv = (const void *) [initIv UTF8String];
    
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCEncrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    
    //编码 base64
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
    result = [GTMBase64 stringByEncodingData:data];
    
    return result;
}

- (NSString*) doCipher:(NSString*)plainText enc:(CCOperation)encryptOrDecrypt{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    
    
    
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData =[NSData  dataWithBase64EncodedString:plainText];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        plainTextBufferSize = [plainText length];
        vplainText = (const void *) [plainText UTF8String];
    }
    
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    //  uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    unsigned char result1[24]= {0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,0,00,00,00,00,0}; unsigned char IV3[8]={0,0,0,0,0,0,0,0};
    
    uint8_t iv[kCCBlockSize3DES];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding ,
                       result1, //"123456789012345678901234", //key
                       kCCKeySize3DES,
                       IV3 ,  //iv,
                       vplainText,  //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else*/ if (ccStatus == kCCParamError) return @"PARAM ERROR";
    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        
        
        result = [ [NSString alloc] initWithData: [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSASCIIStringEncoding];
        
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        NSLog(@"data is: %@", myData);
        result = [myData base64EncodingWithLineLength:myData.length];
        //  result = [[NSString alloc]initWithData:myData encoding:NSUTF8StringEncoding];
    }
    return result;
}
@end
