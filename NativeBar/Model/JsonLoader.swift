//
//  JsonLoader.swift
//  NativeBar
//
//  Created by Tufan Cakir on 15.11.26.
//

import Foundation

func loadLocalJSON<T: Decodable>(_ fileName: String) -> T {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil)
    else {
        fatalError("Datei \(fileName) wurde im Bundle nicht gefunden.")
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Fehler beim Dekodieren von \(fileName): \(error)")
    }
}
