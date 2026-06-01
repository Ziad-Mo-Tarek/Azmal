import OSLog

enum NetworkLogger {
    private static let logger = Logger(subsystem: "com.azmal.pharmacies", category: "network")

    static func debug(_ message: String) {
        logger.debug("\(message)")
    }

    static func error(_ message: String) {
        logger.error("\(message)")
    }
}
