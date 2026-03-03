<<<<<<< HEAD
import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {

=======
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
<<<<<<< HEAD

    // ✅ Ta clé API Google Maps ici
    GMSServices.provideAPIKey("AIzaSyBrzX8NjnZXt6hvuDEjt01NPJCWIsBULq8")

=======
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
