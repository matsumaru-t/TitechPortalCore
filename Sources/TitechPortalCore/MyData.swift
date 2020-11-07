//
//  File.swift
//  
//
//  Created by m.tomoya on 2020/10/31.
//

import Foundation

struct MyData {
    static let usrName = "00B00000"
    static let usrPassword = "000000000000"
    
    static let matrixKey = "ABCDEFGHIJ".flatMap { alpha in
        "1234567".map { num in "\(alpha)\(num)" }
    }
    static let matrixValue = "FHUAGUIWHQHIOFHQOIHFOIBHFUGFIHFWNFOWNEIFHQIHIQHGOINSNFNKHFIENOIWHFIEHO".map { String($0) }
    static let matrix = Dictionary(uniqueKeysWithValues: zip(Self.matrixKey, Self.matrixValue))
}
