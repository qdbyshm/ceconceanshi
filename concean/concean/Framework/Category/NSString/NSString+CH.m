//
//  NSString+CH.m
//  SMZDM
//
//  Created by 李春慧 on 16/6/27.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "NSString+CH.h"

@implementation NSString (CH)


/**
 *  返回文本的size
 *
 *  @param font      字体
 *  @param maxW      最大宽度
 *  @param lineSpace 行间距
 *
 *  @return 文本 size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW lineSpaceing:(CGFloat) lineSpace
{
    
    NSMutableDictionary * attrs = [self dictionaryWithFont:font lineSpaceing:lineSpace];
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attrs context:nil].size;
    
}


- (NSMutableDictionary *) dictionaryWithFont:(UIFont *) font lineSpaceing:(CGFloat) lineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    attrs[NSParagraphStyleAttributeName] = paragraphStyle;
    
    return attrs;
    
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

/**
 * 返回加间距文本
 */
- (NSMutableAttributedString *) attributedStringWithLineSpacing:(CGFloat) space  font:(UIFont *) font
{
    if (![self isSafeString]) return nil;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//调整行间距
    NSDictionary *attributes = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:self];
    [string addAttributes:attributes range:range];
    return string;
}

/**
 *  图片转换成字符串
 *
 *  @param image 要转换的图片
 *
 *  @return 字符串
 */
+ (NSString *)sm_base64StringFromImage:(UIImage *)image
{
    UIImage * fixImage = [NSString fixOrientation:image];
    
    
    NSMutableString *stringValue = [NSMutableString string];
    if (fixImage) {
        NSData *imageData = UIImageJPEGRepresentation(fixImage, .5);
        if (!imageData) {
            imageData = UIImagePNGRepresentation(fixImage);
        }
        if (!imageData) {
            return @"";
        }
        [stringValue appendString:@"data:"];
        [stringValue appendString:[self sm_typeForImageData:imageData]];
        [stringValue appendString:@";base64,"];
        [stringValue appendString:[GTMBase64 stringByEncodingData:imageData]];
    }
    return stringValue;
}

+ (NSString *)sm_typeForImageData:(NSData *)data
{
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
        {
            return @"image/jpeg";
        }
        case 0x89:
        {
            return @"image/png";
        }
        case 0x47:
        {
            return @"image/gif";
        }
        case 0x49:
        case 0x4D:
        {
            return @"image/tiff";
        }
        default:
        {
            return nil;
        }
            
    }
    
    return nil;
}


/**
 图片摆正

 @param aImage 要摆正的图片
 @return  摆正的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {

    if (aImage==nil || !aImage) {
        return nil;
    }

    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    UIImageOrientation orientation = aImage.imageOrientation;
    
    int orientation_ = orientation;
    switch (orientation_) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }

    switch (orientation_) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             
                                             CGImageGetColorSpace(aImage.CGImage),
                                             
                                             CGImageGetBitmapInfo(aImage.CGImage));
    
    CGContextConcatCTM(ctx, transform);

    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    aImage=img;
    img=nil;
    return aImage;
}


///**
// 获取安全字符串 若为非安全字符串返回@“”
// 
// @return 安全字符串
// */
//- (NSString *)getSafeString {
//    
//    if ([self isSafeObj]) {
//        NSString *stringTemp = self;
//        if ([stringTemp isEqualToString:@"<null>"] || [stringTemp isEqualToString:@"(null)"] || [stringTemp isEqualToString:@"null"] || !stringTemp.length) {
//            return @"";
//        }
//        return stringTemp;
//    }
//    
//    return @"";
//
//}

/**
 判断是否为浮点形：
 
 @return YES or NO
 */
- (BOOL)isPureFloat{
    NSString * string = self.mutableCopy;
    if (![self isSafeString]) string = @"0";
    
    NSScanner * scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


/**
 返回当前屏幕对应的图片名称

 @return 图片名称
 */
- (NSString *) currentScreenImageName {
    
    
    if (DEVICE6P) {
        return [NSString stringWithFormat:@"%@_6p", self];
    } else if (DEVICESIX) {
        return [NSString stringWithFormat:@"%@_6", self];
    } else if (DEVICEFIVE) {
        return [NSString stringWithFormat:@"%@_5", self];
    } else if (DEVICEFOUR) {
        return [NSString stringWithFormat:@"%@_4", self];
    }
    return self;
}

@end
