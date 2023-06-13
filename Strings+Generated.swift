// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum NyaStrings {
  /// arrow.backward
  internal static let backwardArrow = NyaStrings.tr("Localizable", "backwardArrow", fallback: "arrow.backward")
  /// Check your internet connection.
  internal static let checkConnection = NyaStrings.tr("Localizable", "checkConnection", fallback: "Check your internet connection.")
  /// Email
  internal static let email = NyaStrings.tr("Localizable", "email", fallback: "Email")
  /// Email already in use.
  internal static let emailInUse = NyaStrings.tr("Localizable", "emailInUse", fallback: "Email already in use.")
  /// Invalid email.
  internal static let invalidEmail = NyaStrings.tr("Localizable", "invalidEmail", fallback: "Invalid email.")
  /// Log In
  internal static let login = NyaStrings.tr("Localizable", "login", fallback: "Log In")
  /// Log Out
  internal static let logout = NyaStrings.tr("Localizable", "logout", fallback: "Log Out")
  /// Don't have an account?
  internal static let noAccountText = NyaStrings.tr("Localizable", "noAccountText", fallback: "Don't have an account?")
  /// There is no user with this identifier.
  internal static let noUserWithThisID = NyaStrings.tr("Localizable", "noUserWithThisID", fallback: "There is no user with this identifier.")
  /// Localizable.strings
  ///   NyaGram
  /// 
  ///   Created by Natalia Rojek on 13/06/2023.
  internal static let nyaGram = NyaStrings.tr("Localizable", "nyaGram", fallback: " NyaGram")
  /// Password
  internal static let password = NyaStrings.tr("Localizable", "password", fallback: "Password")
  /// Register
  internal static let register = NyaStrings.tr("Localizable", "register", fallback: "Register")
  /// Sign Up
  internal static let signUp = NyaStrings.tr("Localizable", "signUp", fallback: "Sign Up")
  /// Unknown error. Try again later.
  internal static let unknownError = NyaStrings.tr("Localizable", "unknownError", fallback: "Unknown error. Try again later.")
  /// Weak password
  internal static let weakPassword = NyaStrings.tr("Localizable", "weakPassword", fallback: "Weak password")
  /// Wrong password.
  internal static let wrongPassword = NyaStrings.tr("Localizable", "wrongPassword", fallback: "Wrong password.")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension NyaStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
