//
//  NSString+MJExtension.m
//  MJExtensionExample
//
//  Created by MJ Lee on 15/6/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "NSString+MJExtension.h"

@implementation NSString (MJExtension)
//  驼峰转下划线
- (NSString *)mj_underlineFromCamel
{
    //  边界条件，长度为0时根本不用转换
    if (self.length == 0) return self;
    //  创建一个可变的NSString，一会把这个数组返回
    NSMutableString *string = [NSMutableString string];
    //  对NSString进行遍历
    for (NSUInteger i = 0; i<self.length; i++) {
        //  获取每一位的char型元素
        unichar c = [self characterAtIndex:i];
        //  转换为NSString，为的是能更方便的将其转化为小写字母
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        //  转化为小写字母
        NSString *cStringLower = [cString lowercaseString];
        //  当这个char本身就是小写时，直接append到可变数组string后面就行
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
            //  如果char本身是个大写的字母，那么首先要在该字母之前加一个下划线
            //  再把该字母append到后面
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

//  从下划线形式转化为驼峰形式
- (NSString *)mj_camelFromUnderline
{
    //  边界条件，长度为0时根本不用转换
    if (self.length == 0) return self;
    //  创建一个可变NSString，一会把这个数组返回
    NSMutableString *string = [NSMutableString string];
    //  返回的数组里包含由下划线分隔开的单词们
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    //  对于cmps数组中每一个元素，进行遍历
    for (NSUInteger i = 0; i<cmps.count; i++) {
        
        NSString *cmp = cmps[i];
        //  i>0 且单词的长度是 >0 的时候才会执行这个
        //  相当于不处理第一个单词，因为驼峰表示法里首单词就是小写形式的
        if (i && cmp.length) {
            //  把单词的第一个字母转化为大写的，并append到可变的NSString中
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            //  把剩下的元素也append到可变的NSString中去
            //  判断条件是cmp.length >= 2是说除去首字母之后还有元素的话才需要加进去
            //  如果只有首字母就不用进行这一步了
            if (cmp.length >= 2) [string appendString:[cmp substringFromIndex:1]];
        } else {
            //  处理第一个单词，直接append到可变NSString中
            [string appendString:cmp];
        }
    }
    return string;
}

//  首字母变小写
- (NSString *)mj_firstCharLower
{
    //  边界条件，长度为0时根本不用转换
    if (self.length == 0) return self;
    //  创建一个可变NSString，一会把这个数组返回
    NSMutableString *string = [NSMutableString string];
    //  把首字母变成小写的，然后append到可变的NSString中去
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    //  把剩下的元素也append到可变的NSString中去
    //  判断条件是self.length >= 2是说除去首字母之后还有元素的话才需要加进去
    //  如果只有首字母就不用进行这一步了
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

//  首字母变大写
- (NSString *)mj_firstCharUpper
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

//  是否是纯数组
- (BOOL)mj_isPureInt
{
    //  NSScanner类是一个类簇的抽象超类，为一个scanNSString对象声明可编程接口
    //  Returns an NSScanner object that scans a given string.
    NSScanner *scan = [NSScanner scannerWithString:self];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}

//
- (NSURL *)mj_url
{
//    [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"]];
    
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
}
@end

@implementation NSString (MJExtensionDeprecated_v_2_5_16)
- (NSString *)underlineFromCamel
{
    return self.mj_underlineFromCamel;
}

- (NSString *)camelFromUnderline
{
    return self.mj_camelFromUnderline;
}

- (NSString *)firstCharLower
{
    return self.mj_firstCharLower;
}

- (NSString *)firstCharUpper
{
    return self.mj_firstCharUpper;
}

- (BOOL)isPureInt
{
    return self.mj_isPureInt;
}

- (NSURL *)url
{
    return self.mj_url;
}
@end
