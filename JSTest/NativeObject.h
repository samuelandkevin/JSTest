//
//  NativeObject.h
//  JSTest
//
//  Created by 李 忠福 on 13-7-3.
//  Copyright (c) 2013年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
@import JavaScriptCore;

@protocol NativeObjectExport <JSExport>
-(void)log:(NSString*)string;
@end

@interface NativeObject : NSObject <NativeObjectExport>

@end
