//
//  File.swift
//
//
//  Created by Kris Steigerwald on 3/16/23.
//
import os

private let subsystem = "com.Velaru.SurveyMakito"

// MARK: - Protocol

protocol LogProducer {
    func debug(_ message: StaticString, _ messageArguments: CVarArg...)
    func info(_ message: StaticString, _ messageArguments: CVarArg...)
    func warn(_ message: StaticString, _ messageArguments: CVarArg...)
    func fault(_ message: StaticString, _ messageArguments: CVarArg...)
    func error(_ message: StaticString, _ messageArguments: CVarArg...)
}

// MARK: - Implementation

/// A convenience wrapper for `OSLog`
struct Logger: LogProducer {
    private let log: OSLog

    init(_ category: String) {
        self.log = OSLog(subsystem: subsystem, category: category)
    }

    // MARK: Log Methods

    // LOL, this method sucks ATM since Swift doesn't allow the forwarding of variadic params.
    private func log(_ message: StaticString, _ type: OSLogType, _ messageArguments: [CVarArg]) {
        switch messageArguments.count {
        case 0:
            os_log(message, log: log, type: type)
        case 1:
            os_log(message, log: log, type: type, messageArguments[0])
        case 2:
            os_log(message, log: log, type: type, messageArguments[0], messageArguments[1])
        case 3:
            os_log(message, log: log, type: type, messageArguments[0], messageArguments[1], messageArguments[2])
        case 4:
            os_log(message, log: log, type: type, messageArguments[0], messageArguments[1], messageArguments[2], messageArguments[3])
        case 5:
            os_log(message, log: log, type: type, messageArguments[0], messageArguments[1], messageArguments[2], messageArguments[3], messageArguments[4])
        default:
            os_log("Too many variadic params were sent to the logger so we tossed them!", log: log, type: .error)
            os_log(message, log: log, type: type)
        }
    }

    func debug(_ message: StaticString, _ messageArguments: CVarArg...) {
        log(message, .debug, messageArguments)
    }

    func info(_ message: StaticString, _ messageArguments: CVarArg...) {
        log(message, .info, messageArguments)
    }

    func warn(_ message: StaticString, _ messageArguments: CVarArg...) {
        log(message, .default, messageArguments)
    }

    func fault(_ message: StaticString, _ messageArguments: CVarArg...) {
        log(message, .fault, messageArguments)
    }

    func error(_ message: StaticString, _ messageArguments: CVarArg...) {
        log(message, .error, messageArguments)
    }
}
