//
//  SerializationService.swift
//  Cars
//
//  Created by Pavel on 1.01.24.
//

import SwiftUI

final class SerializationService {
    static func encodeColor(_ color: Color) -> Data {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(color)
        } catch {
            print("Error encoding color: \(error)")
            return Data()
        }
    }
    
    static func decodeColor(from data: Data) throws -> Color {
        let decoder = JSONDecoder()
        return try decoder.decode(Color.self, from: data)
    }
}
