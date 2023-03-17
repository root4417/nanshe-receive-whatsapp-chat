#import "ReceiveWhatsappChatPlugin.h"

@implementation ReceiveWhatsappChatPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.whatsapp.chat/chat"
            binaryMessenger:[registrar messenger]];
  ReceiveWhatsappChatPlugin* instance = [[ReceiveWhatsappChatPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"analyze" isEqualToString:call.method]) {
    NSString* URL = call.arguments[@"data"];
    NSURL* students = [NSURL URLWithString:URL];
    NSError* error;
    NSData* data = [NSData dataWithContentsOfURL:students options:NSDataReadingUncached error:&error];
    if (data != nil) {
      NSString* content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSArray* lines = [content componentsSeparatedByString:@"\n"];
      result(lines);
    } else {
      NSLog(@"Error: %@", error.localizedDescription);
      result(nil);
    }
  } else if ([@"getImage" isEqualToString:call.method]) {
    NSString* URL = call.arguments[@"data"];
    NSURL* students = [NSURL fileURLWithPath:URL];
    NSError* error;
    NSData* data = [NSData dataWithContentsOfURL:students options:NSDataReadingUncached error:&error];
    if (data != nil) {
      result(data);
    } else {
      NSLog(@"Error: %@", error.localizedDescription);
      result(nil);
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
