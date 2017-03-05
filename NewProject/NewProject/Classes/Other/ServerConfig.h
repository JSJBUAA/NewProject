//
//  ServerConfig.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#ifndef ServerConfig_h
#define ServerConfig_h

#define HTTPWebString           @"http://"
#define HTTPSWebString          @"https://"

#define HTTPURLString(prefix, suffix)     [NSString stringWithFormat:@"%@%@%@",HTTPWebString,\
                                              prefix,suffix]
#define HTTPSURLString(prefix, suffix)    [NSString stringWithFormat:@"%@%@%@",HTTPSWebString,\
                                          prefix,suffix]

#define HTTPURLString_API(suffix)        HTTPURLString(kAPIRequestDomain,suffix)
#define HTTPSURLString_API(suffix)       HTTPSURLString(kAPIRequestDomain,suffix)

#endif /* ServerConfig_h */
