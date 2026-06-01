//
//  MultipleDecodingErrors.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 29/05/2026.
//


import Foundation

public struct MultipleDecodingErrors: Error {
    public let errors: [DecodingError]
    
    public var description: String {
        errors.map { $0.description }.joined(separator: "\n")
    }
    
    public static func failure(_ errors: [DecodingError]) -> MultipleDecodingErrors {
        .init(errors: errors)
    }
}
