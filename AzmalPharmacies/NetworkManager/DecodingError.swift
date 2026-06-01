//
//  DecodingError.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 29/05/2026.
//


import Foundation

public enum DecodingError: Error {
    case missingKey(String)
    case typeMismatch(String, expectedType: String)
    case dataCorrupted(String)
    case other(Error)
    
    public var description: String {
        switch self {
        case .missingKey(let key):
            return "Missing key: \(key)"
        case .typeMismatch(let path, let expectedType):
            return "Type mismatch at path: \(path), expected type: \(expectedType)"
        case .dataCorrupted(let message):
            return "Data corrupted: \(message)"
        case .other(let error):
            return "Other error: \(error.localizedDescription)"
        }
    }
}