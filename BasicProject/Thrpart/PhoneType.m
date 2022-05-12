//
//  PhoneType.m
//  LoveCat
//
//  Created by jingjun on 2021/1/10.
//

#import "PhoneType.h"
#import <sys/utsname.h>

@implementation PhoneType

+ (NSString *)getDeviceModel{
    struct utsname
    systemInfo;

    uname(&systemInfo);

    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";

    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";

    //TODO:iPhone//2020年10月14日，新款iPhone 12 mini、12、12 Pro、12 Pro Max发布

    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";

    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";

    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";

    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";


    //2020年4月15日，新款iPhone SE发布

    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2020";



    //2019年9月11日，第十四代iPhone 11，iPhone 11 Pro，iPhone 11 Pro Max发布

    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";



    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";



    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";



    //2018年9月13日，第十三代iPhone XS，iPhone XS Max，iPhone XR发布

    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";



    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";



    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";

    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";



    //2017年9月13日，第十二代iPhone 8，iPhone 8 Plus，iPhone X发布



    if ([platform isEqualToString:@"iPhone10,1"])return @"iPhone 8";



    if ([platform isEqualToString:@"iPhone10,4"])return @"iPhone 8";



    if ([platform isEqualToString:@"iPhone10,2"])return @"iPhone 8 Plus";



    if ([platform isEqualToString:@"iPhone10,5"])return @"iPhone 8 Plus";



    if ([platform isEqualToString:@"iPhone10,3"])return @"iPhone X";



    if ([platform isEqualToString:@"iPhone10,6"])return @"iPhone X";



    /*2007年1月9日，第一代iPhone 2G发布；

     2008年6月10日，第二代iPhone 3G发布 [1]；

     2009年6月9日，第三代iPhone 3GS发布 [2]；

     2010年6月8日，第四代iPhone 4发布；

     2011年10月4日，第五代iPhone 4S发布；

     2012年9月13日，第六代iPhone 5发布；

     2013年9月10日，第七代iPhone 5C及iPhone 5S发布；

     2014年9月10日，第八代iPhone 6及iPhone 6 Plus发布；

     2015年9月10日，第九代iPhone 6S及iPhone 6S Plus发布；

     2016年3月21日，第十代iPhone SE发布；

     2016年9月8日，第十一代iPhone 7及iPhone 7 Plus发布；

     */

    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";

    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";

    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";

    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";

    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";

    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";

    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";

    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";

    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";

    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";

    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";

    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";

    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";

    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s";

    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";

    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";

    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";

    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";

    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";



    //TODO:iPod

    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch";

    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch";

    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch";

    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch";

    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch";

    if ([platform isEqualToString:@"iPod7,1"]) return @"iPod touch";



    //2019年5月发布，更新一种机型：iPod touch (7th generation)

    if ([platform isEqualToString:@"iPod9,1"]) return @"iPod touch";





    //TODO:iPad

    if([platform isEqualToString:@"iPad1,1"])return@"iPad 1G";

    if([platform isEqualToString:@"iPad2,1"])return@"iPad 2";

    if([platform isEqualToString:@"iPad2,2"])return@"iPad 2";

    if([platform isEqualToString:@"iPad2,3"])return@"iPad 2";

    if([platform isEqualToString:@"iPad2,4"])return@"iPad 2";

    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";

    if([platform isEqualToString:@"iPad3,1"])return@"iPad 3";

    if([platform isEqualToString:@"iPad3,2"])return@"iPad 3";

    if([platform isEqualToString:@"iPad3,3"])return@"iPad 3";

    if([platform isEqualToString:@"iPad3,4"])return@"iPad 4";

    if([platform isEqualToString:@"iPad3,5"])return@"iPad 4";

    if([platform isEqualToString:@"iPad3,6"])return@"iPad 4";

    if([platform isEqualToString:@"iPad4,1"])return@"iPad Air";

    if([platform isEqualToString:@"iPad4,2"])return@"iPad Air";

    if([platform isEqualToString:@"iPad4,3"])return@"iPad Air";

    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad Mini";

    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad 5";

    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad 5";

    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad Pro";

    if ([platform isEqualToString:@"iPad7,4"]) return @"iPad Pro";



    //2019年3月发布，更新二种机型：iPad mini、iPad Air

    if ([platform isEqualToString:@"iPad11,1"]) return @"iPad mini";

    if ([platform isEqualToString:@"iPad11,2"]) return @"iPad mini";

    if ([platform isEqualToString:@"iPad11,3"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad11,4"]) return @"iPad Air";

    return platform;

}
@end
