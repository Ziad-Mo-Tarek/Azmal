import OSLog

enum AppLogger {
    private static let logger = Logger(subsystem: "com.azmal.pharmacies", category: "app")

    static func debug(_ message: String) {
        logger.debug("\(message)")
    }

    static func error(_ message: String) {
        logger.error("\(message)")
    }
}
