//
//  DevnagriSdk.h
//  DevnagriSdkObjc
//
//  Created by Dinesh Gautam on 27/04/22.
//

#import <Foundation/Foundation.h>
#import "NSBundle+DevnagriSDK.h"
NS_ASSUME_NONNULL_BEGIN


@interface DevnagriSdk : NSObject
{
  
}


+ (nonnull instancetype)shared;
-(void)initSdk:(NSString *)apiKey updateStringsTime:(int)inMinutes;
-(NSString *)getCurrentApplicationLanguageCode;
-(NSDictionary *)getEnglishStrings;
-(void)updateAppLocale:(NSString *)code;
-(void)updateTranslations;
-(void)getAllSupportableLanguagesCallback:(void (^)(NSArray *arrAllSupportingLang))callback;
-(void)getTranslationOfStringWithSentence:(NSString *)sentence callback:(void (^)(NSString *strTranslation))callback;
-(void)getTranslationOfStringsWithSentences:(NSArray *)sentences callback:(void (^)(NSArray *arrTranslations))callback;
-(void)getTranslationsOfDictionary:(NSDictionary *)dictionary callback:(void (^)(NSDictionary *dictTranslation))callback;
@end

NS_ASSUME_NONNULL_END
