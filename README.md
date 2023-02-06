# iOS SDK Installation Instructions
Learn how to install the Devnagri SDK for iOS.

# Introduction
Devnagri Over the Air for iOS lets you update translations in your iOS app without having to release it every single time.

By including our SDK, your app will check for updated translations in Devnagri regularly and download them in the background.

You can install the SDK manually.

**Do note**: The language selection screen needs to be designed by the client. We only empower localisation of the app.

# Manual Installation
Download the latest release from https://github.com/DevnagriAI/dota-sdk-ios/releases 
Add DevnagriSdkObjc.xcframework in Xcode as linked binary to your target.

**Optional for development**

The Apple store will reject your app if it includes simulator binaries. Therefore, a script to strip the extra binaries needs to be run before you upload the app. To do this, go to Build Phases and add a Run Script section by clicking the + symbol. Copy and paste the following script:

      FRAMEWORK="DevnagriSDK"
      FRAMEWORK_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/$FRAMEWORK.framework/$FRAMEWORK"
      EXTRACTED_ARCHS=()
      for ARCH in $ARCHS
      do
         lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
         EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
      done
      lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
      rm "${EXTRACTED_ARCHS[@]}"
      rm "$FRAMEWORK_EXECUTABLE_PATH"
      mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

# Compatibility
We support latest Xcode 13+ and Objective C language. This SDK requires base language as english. Other base languages will not supported by this SDK. Minimum iOS Version supported is 12

# Configuration

        @import DevnagriSdkObjc;


Initialize the SDK by calling the following code in your didFinishLaunchingWithOptions Method and you can get API_KEY from devnagri

*updateStringTime* is an optional parameter 
For auto update strings translations you can set time in minutes.

     - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
             [[DevnagriSdk shared] initSdk:@"API-KEY" updateStringsTime:10];
                 return YES;
      }
     
# Default Localisation Override
   The SDK override the functionality of NSLocalisedString by default. You just need to import the DevnagriSdk to the file where you want NSLocalisedString to be override by the SDK.
   
# Change Language
In case you don't want to use the system language, you can set a different language in the updateAppLocale method. The language code (locale) needs to be present in a release from Devnagri.

          [[DevnagriSdk shared] updateAppLocale:@"hi"];
      
  Please note that you will see the english text back if your device language is english and you have not set any specific language for the SDK. To get the translation in Hindi, Please update app locale to Hindi as per above method.
  
# Get Current language code
In case you want to know which language code currently used by application.

        NSString *currentLanguageCode = [[DevnagriSdk shared] getCurrentApplicationLanguageCode];

# Update Translations
In case you want to update english localisation strings translations according to selected application locale.  

        [[DevnagriSdk shared] updateTranslations];
 
    
# Get Supported Languages
You can get supported languages for the SDK using this method. This will return hashmap of language name and language code

    [[DevnagriSdk shared] getAllSupportableLanguagesCallback:^(NSArray * _Nonnull arrAllSupportingLang) {
         // Do your stuff here
        
     }];
 
# Translate String, List and Dictionary on runtime
You can use these methods anywhere in your project and these will provide translation for current active locale in callback method.

    Get Translation of a Specific String

    NSString *strSentence = @"My Home";
    [[DevnagriSdk shared] getTranslationOfStringWithSentence:strSentence callback:^(NSString * _Nonnull strTranslation) {
        NSLog(@"Translation of Sentence %@ is %@",strSentence, strTranslation);
    }];

Get Translations of an Array of Strings.

    NSArray *arrSentences = [NSArray arrayWithObjects:@"My Home",@"Hello World", nil];
    [[DevnagriSdk shared] getTranslationOfStringsWithSentences:arrSentences callback:^(NSArray * _Nonnull arrTranslations) {
        for (int i = 0; i < arrTranslations.count; i ++)
        {
            NSLog(@"Translation of array Sentences %@ is %@",[arrSentences objectAtIndex:i], [arrTranslations objectAtIndex:i]);
        }
     }];

Get Translations Of Dictionary

    NSDictionary *dictSentences = [NSDictionary dictionaryWithObjectsAndKeys:@"My Home",@"my_home", @"Hello World",@"hello_world", nil];
    [[DevnagriSdk shared] getTranslationsOfDictionary:dictSentences callback:^(NSDictionary * _Nonnull dictTranslation) {
        for (NSString *strKey in dictTranslation) {
            NSLog(@"Translation of dict Sentences key =  %@ resp =  %@",strKey, [dictTranslation objectForKey:strKey]);
        }
    }];

# Usage

Select project target and click general select in framework,libraries,and Embedded Content and select *DevnagriSdkObjc.xcframework* if not selected 
than choose **Embed -> Embed & Sign.**

