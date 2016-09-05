//
//  ViewController.m
//  JSTest
//
//  Created by 李 忠福 on 13-7-2.
//  Copyright (c) 2013年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>
#import "NativeObject.h"

@protocol UIButtonExport <JSExport>
- (void)setTitle:(NSString *)title forState:(UIControlState)state;
@end


@implementation ViewController

- (void) testLog
{
    JSContext *context = [[JSContext alloc] init];
    context[@"nativeObject"] = [[NativeObject alloc] init];
    
    [context evaluateScript:@"nativeObject.log(\"Hello Javascript\")"];
}

- (void) test
{
    class_addProtocol([UIButton class], @protocol(UIButtonExport));
    
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Hello Objective-C" forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 40, 280, 40);
    
    
    JSContext *context = [[JSContext alloc] init];
	context[@"button"] = button;
	[context evaluateScript:@"button.setTitleForState('Hello JavaScript', 0)"];
    
    [self.view addSubview:button];
}

- (void) factorial
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    NSString *testScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:testScript];
    
    JSValue *function = context[@"factorial"];
    JSValue *result = [function callWithArguments:@[@10]];
    NSLog(@"factorial(10) = %d", [result toInt32]);
}

- (void) testMakeUIColor
{
    JSContext *context = [[JSContext alloc] init];
    
    context[@"creatUIColor"] = ^(NSDictionary *rgbColor){
        return [UIColor colorWithRed:([rgbColor[@"red"] floatValue] / 255.0)
                               green:([rgbColor[@"green"] floatValue] / 255.0)
                                blue:([rgbColor[@"blue"] floatValue] / 255.0)
                               alpha:1];
    };
    JSValue *color = [context evaluateScript:@"makeUIColor({red: 150, green: 150, blue: 200})"];
    NSLog(@"color:%@",[color toObject]);
}

- (void) global
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    NSString *testScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:testScript];
    
    JSValue *jsValue = context[@"globalVariable"];
    NSString *globalVariableString = [jsValue toString];
    NSLog(@"globalVariableString:%@", globalVariableString);
    
    JSValue *jsValueDic = context[@"globalObject"];
    NSDictionary *globalDic = [jsValueDic toDictionary];
    NSLog(@"globalObject:%@", globalDic);
}

- (void) memeryTest
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self memeryTest];
}



@end
