import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Executable form of PLATFORM_UPDATES.md: the store and OS requirements we
/// can check from files. When a requirement is added to the registry and it is
/// checkable, add its test here.
void main() {
  final plist = File('ios/Runner/Info.plist').readAsStringSync();
  final pbxproj = File('ios/Runner.xcodeproj/project.pbxproj')
      .readAsStringSync();
  final manifest = File('android/app/src/main/AndroidManifest.xml')
      .readAsStringSync();
  final gradle = File('android/app/build.gradle.kts').readAsStringSync();

  group('iOS (PLATFORM_UPDATES: IOS-001..IOS-006)', () {
    test('UIScene lifecycle is adopted (mandatory when building with the iOS 27 SDK)', () {
      expect(plist, contains('UIApplicationSceneManifest'));
      expect(plist, contains('UISceneDelegateClassName'));
      final scene = File('ios/Runner/SceneDelegate.swift').readAsStringSync();
      expect(scene, contains('FlutterSceneDelegate'));
      final appDelegate = File('ios/Runner/AppDelegate.swift')
          .readAsStringSync();
      expect(appDelegate, contains('FlutterImplicitEngineDelegate'));
      expect(appDelegate, contains('didInitializeImplicitFlutterEngine'));
    });

    test('deployment target is iOS 15 or later (required from April 2027)', () {
      final targets = RegExp(r'IPHONEOS_DEPLOYMENT_TARGET = ([\d.]+);')
          .allMatches(pbxproj)
          .map((m) => m.group(1)!);
      expect(targets, isNotEmpty);
      for (final t in targets) {
        expect(
          double.parse(t),
          greaterThanOrEqualTo(15.0),
          reason: 'deployment target $t',
        );
      }
    });

    test('a launch screen is declared', () {
      expect(plist, contains('UILaunchStoryboardName'));
    });

    test('iPhone orientations are not locked: iPhone Duo resizes and rotates (Apple: fixed orientations break layouts)', () {
      final iphone = RegExp(
        r'<key>UISupportedInterfaceOrientations</key>\s*<array>(.*?)</array>',
        dotAll: true,
      ).firstMatch(plist)!.group(1)!;
      expect(iphone, contains('UIInterfaceOrientationPortrait'));
      expect(iphone, contains('UIInterfaceOrientationLandscapeLeft'));
      expect(iphone, contains('UIInterfaceOrientationLandscapeRight'));
      expect(plist, isNot(contains('UIRequiresFullScreen')));
    });

    test('the launcher name comes from Brand.xcconfig, not a literal', () {
      expect(plist, contains(r'$(APP_DISPLAY_NAME)'));
      expect(
        File('ios/Flutter/Brand.xcconfig').readAsStringSync(),
        contains('APP_DISPLAY_NAME'),
      );
    });
  });

  group('Android (foldables and large screens)', () {
    test('activity is resizeable and never locks orientation', () {
      expect(manifest, contains('android:resizeableActivity="true"'));
      expect(manifest, isNot(contains('android:screenOrientation')));
    });

    test('handles size and fold configuration changes without restarting', () {
      for (final c in [
        'screenSize',
        'smallestScreenSize',
        'screenLayout',
        'orientation',
        'density',
      ]) {
        expect(manifest, contains(c));
      }
    });

    test('network permissions are declared for release builds', () {
      expect(manifest, contains('android.permission.INTERNET'));
      expect(manifest, contains('android.permission.ACCESS_NETWORK_STATE'));
    });

    test('release builds are shrunk (download budget)', () {
      expect(gradle, contains('isMinifyEnabled = true'));
      expect(gradle, contains('isShrinkResources = true'));
    });

    test('the launcher name comes from strings.xml, not a literal', () {
      expect(manifest, contains('@string/app_name'));
    });
  });
}
