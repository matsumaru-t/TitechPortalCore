//
//  File.swift
//  
//
//  Created by m.tomoya on 2020/11/07.
//

import Foundation
import Kanna

struct MatrixKeyParser {
    static func parse(_ data: Data) -> [String] {
        do {
            let doc = try HTML(html: data, encoding: .utf8)
            return doc
                .css("th")
                .map { $0.innerHTML!.components(separatedBy: CharacterSet(charactersIn: "[,]")).joined() }
                .filter { !$0.isEmpty }
        } catch {
            return []
        }
    }
}
