// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum Localizations {
  private static var englishBundle = Bundle(url: Bundle(for: BundleToken.self)
    .url(forResource: "en", withExtension: "lproj")!)!

  internal enum SplashScreen {
    /// Splash
    internal static let title = Localizations.tr("Localizations", "SplashScreen.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Localizations {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        func localizedString(_ table: String, _ key: String, _ args: [CVarArg], bundle: Bundle) -> String {
            let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
            return String(format: format, locale: Locale.current, arguments: args)
        }
        let string = localizedString(table, key, args, bundle: Bundle(for: BundleToken.self))
        if string != key {
            return string
        } else {
            return localizedString(table, key, args, bundle: englishBundle)
        }
    }
}

private final class BundleToken {}
