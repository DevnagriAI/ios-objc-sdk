//
//  ViewController.m
//  SampleSDKDevNagri
//
//  Created by Dinesh Gautam on 25/05/22.
//

#import "ViewController.h"
@import DevnagriSdkObjc;

@interface ViewController ()
{
 }
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initiaise the SDK
     [[DevnagriSdk shared] initSdk:@"devnagri_083525d4b71411eca510021b26013360" updateStringsTime:10];
    
    // Update locale to hindi
    [[DevnagriSdk shared] updateAppLocale:@"hi"];
    
    // get all supported languages
    [[DevnagriSdk shared] getAllSupportableLanguagesCallback:^(NSArray * _Nonnull arrAllSupportingLang) {
        // Do your stuff here
        NSLog(@"All languages %@",arrAllSupportingLang);
    }];
    
//    // Translation of String
    NSString *strSentence = @"My Home";
    [[DevnagriSdk shared] getTranslationOfStringWithSentence:strSentence callback:^(NSString * _Nonnull strTranslation) {
        NSLog(@"Translation of Sentence %@ is %@",strSentence, strTranslation);
    }];

    // get translation of array
    NSArray *arrSentences = [NSArray arrayWithObjects:@"My Home",@"Hello World", nil];
    [[DevnagriSdk shared] getTranslationOfStringsWithSentences:arrSentences callback:^(NSArray * _Nonnull arrTranslations) {
        for (int i = 0; i < arrTranslations.count; i ++)
        {
            NSLog(@"Translation of array Sentences %@ is %@",[arrSentences objectAtIndex:i], [arrTranslations objectAtIndex:i]);
        }

    }];
    
    //get translation of dictionary
    NSDictionary *dictSentences = [NSDictionary dictionaryWithObjectsAndKeys:@"My Home",@"my_home", @"Hello World",@"hello_world", nil];
    [[DevnagriSdk shared] getTranslationsOfDictionary:dictSentences callback:^(NSDictionary * _Nonnull dictTranslation) {
        for (NSString *strKey in dictTranslation) {
            NSLog(@"Translation of dict Sentences key =  %@ resp =  %@",strKey, [dictTranslation objectForKey:strKey]);
        }
    }];
     
    NSLog(NSLocalizedString(@"what_is_your_name", ""));
 
    // Do any additional setup after loading the view.
}


@end
