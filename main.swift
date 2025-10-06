import UIKit
import Flutter

// This is a workaround for old Flutter versions that did not generate a main.m file.
// Remove this file once your minimum target >= 12.0.

FlutterMain.startFlutter()
UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  nil,
  NSStringFromClass(AppDelegate.self)
)
