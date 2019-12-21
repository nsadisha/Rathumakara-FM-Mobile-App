package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.adrianczuczka.audiostreamplayer.AudioStreamPlayerPlugin;
import com.example.systemshortcuts.SystemShortcutsPlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;
import com.example.volume.VolumePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AudioStreamPlayerPlugin.registerWith(registry.registrarFor("com.adrianczuczka.audiostreamplayer.AudioStreamPlayerPlugin"));
    SystemShortcutsPlugin.registerWith(registry.registrarFor("com.example.systemshortcuts.SystemShortcutsPlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
    VolumePlugin.registerWith(registry.registrarFor("com.example.volume.VolumePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
