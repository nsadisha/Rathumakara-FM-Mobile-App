//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <audio_stream_player/AudioStreamPlayerPlugin.h>
#import <system_shortcuts/SystemShortcutsPlugin.h>
#import <url_launcher/UrlLauncherPlugin.h>
#import <volume/VolumePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AudioStreamPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"AudioStreamPlayerPlugin"]];
  [SystemShortcutsPlugin registerWithRegistrar:[registry registrarForPlugin:@"SystemShortcutsPlugin"]];
  [FLTUrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTUrlLauncherPlugin"]];
  [VolumePlugin registerWithRegistrar:[registry registrarForPlugin:@"VolumePlugin"]];
}

@end
