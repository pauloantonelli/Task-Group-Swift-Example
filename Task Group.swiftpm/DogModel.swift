//
//  SlowDivideOperation.swift
//  Task Group
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation

struct DogModel: Codable {
    let message: String
    let status: String
    var id: String {
        message
    }
    var url: URL {
        URL(string: message)!
    }
}

