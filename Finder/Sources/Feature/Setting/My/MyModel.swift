//
//  MyModel.swift
//  Finder
//
//  Created by dgsw30 on 12/19/24.
//

import Foundation

struct MyModelStatus: Codable, StatusResponse {
    let data: MyModel?
}

struct MyModel: Codable {}
