//
//  LoadingDialogExtension.m
//  LoadingDialogExtension
//
//  Created by shaun mitchell on 12/09/2013.
//  Copyright (c) 2013 Tombola. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "MBProgressHUD.h"

MBProgressHUD *HUD;

FREObject showSpinnerWithLabel(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    uint32_t string1Length;
    const uint8_t *string1;
    FREGetObjectAsUTF8(argv[0], &string1Length, &string1);
    
    NSString *string1ObjC = [NSString stringWithUTF8String:(char*)string1];

    UIWindow* wind = [[UIApplication sharedApplication] keyWindow];
    
    HUD = [[MBProgressHUD alloc] initWithView:wind];
    HUD.labelText = string1ObjC;
    
	[wind addSubview:HUD];
    
    [HUD show:YES];
    
    return NULL;
}

FREObject hideSpinner(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [HUD hide:YES];
    return NULL;
}

FREObject dispose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
   UIWindow* wind = [[UIApplication sharedApplication] keyWindow];
    
    for (UIView *subView in wind.subviews)
    {
        
        if ([subView isKindOfClass:[MBProgressHUD class]])
        {
            
            [subView removeFromSuperview];
        }
    }
    
    return NULL;
}


void LoadingSpinnerExtensionContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 3;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * *numFunctionsToTest);
    
    func[0].name = (const uint8_t*) "showSpinnerWithLabel";
    func[0].functionData = NULL;
    func[0].function = &showSpinnerWithLabel;
    
    func[1].name = (const uint8_t*) "hideSpinner";
    func[1].functionData = NULL;
    func[1].function = &hideSpinner;
    
    func[2].name = (const uint8_t*) "dispose";
    func[2].functionData = NULL;
    func[2].function = &dispose;
                                                        
    *functionsToSet = func;
}

void LoadingSpinnerExtensionContextFinalizer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
}


void LoadingSpinnerExtensionIntitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &LoadingSpinnerExtensionContextInitializer;
}

void LoadingSpinnerExtensionFinalizer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &LoadingSpinnerExtensionContextFinalizer;
}







