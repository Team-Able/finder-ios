//
//  StatusResponse.swift
//  Finder
//
//  Created by dgsw30 on 12/17/24.
//

import Foundation

protocol StatusResponse {
    var status: Int { get }
    var message: String { get }
}

extension StatusResponse {
    var status: Int {
        return 0
    }
    var message: String {
        return "No message"
    }
}
