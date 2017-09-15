//
//  UIDevice+Additions.m
//  SMZDM
//
//  Created by ZhangWenhui on 16/2/2.
//  Copyright © 2016年 smzdm. All rights reserved.
//

#import "UIDevice+Additions.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <sys/mount.h>

//#import <sys/stat.h>
//#include <sys/types.h>
//#import <sys/socket.h>
//#import <sys/param.h>
//#import <mach/mach_host.h>
//#import <mach/processor_info.h>

@implementation UIDevice (Additions)

+ (NSString*)hardwareString
{
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

+ (NSString*)machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return deviceString;
}

+ (NSString *)macAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

//系统固件版本
+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - sysctl utils
+ (NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)cpuFrequency {
    return [self getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)busFrequency {
    return [self getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ramSize {
    return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
    return [self getSysInfo:HW_NCPU];
}


+ (NSUInteger)totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information
+ (long long)freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}

+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

+ (NSString *)machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self machineModel];
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch",
                              @"Watch1,2" : @"Apple Watch",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5 (GSM)",
                              @"iPhone5,2" : @"iPhone 5 (CDMA)",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2 (WiFi)",
                              @"iPad2,5" : @"iPad mini 1 (WiFi)",
                              @"iPad2,6" : @"iPad mini 1 (GSM)",
                              @"iPad2,7" : @"iPad mini 1 (CDMA)",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (CDMA)",
                              @"iPad3,3" : @"iPad 3 (GSM)",
                              @"iPad3,4" : @"iPad 4 (WiFi)",
                              @"iPad3,5" : @"iPad 4 (GSM)",
                              @"iPad3,6" : @"iPad 4 (CDMA)",
                              @"iPad4,1" : @"iPad Air (WiFi)",
                              @"iPad4,2" : @"iPad Air (GSM)",
                              @"iPad4,3" : @"iPad Air (CDMA)",
                              @"iPad4,4" : @"iPad mini 2 (WiFi)",
                              @"iPad4,5" : @"iPad mini 2 (Cellular)",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3 (WiFi)",
                              @"iPad4,8" : @"iPad mini 3 (Cellular)",
                              @"iPad4,9" : @"iPad mini 3 (Cellular)",
                              @"iPad5,1" : @"iPad mini 4 (WiFi)",
                              @"iPad5,2" : @"iPad mini 4 (Cellular)",
                              @"iPad5,3" : @"iPad Air 2 (WiFi)",
                              @"iPad5,4" : @"iPad Air 2 (Cellular)",
                              @"iPad6,3" : @"iPad Pro 9.7-inch (WiFi)",
                              @"iPad6,4" : @"iPad Pro 9.7-inch (Cellular)",
                              @"iPad6,7" : @"iPad Pro 12.9-inch (WiFi)",
                              @"iPad6,8" : @"iPad Pro 12.9-inch (Cellular)",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

@end
