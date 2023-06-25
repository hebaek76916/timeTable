//
//  TimeTableResponseModel.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import Foundation

struct TimeTableResponse: Decodable {
    let items: [Item]?
    let count, scannedCount: Int?
    
    struct Item: Decodable {
        let code: String?
        
        enum CodingKeys: String, CodingKey {
            case code = "lecture_code"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case count = "Count"
        case scannedCount = "ScannedCount"
    }
}

enum TimeTableResponseMapper {
    
    private static var statusCode200: Int { return 200 }
    
    static func map(data: Data, response: HTTPURLResponse) -> TimeTableService.Result {
        guard
            response.statusCode == statusCode200
        else { return .failure(.invalidStatusCode) }
        
        guard
            let json = try? JSONDecoder().decode(TimeTableResponse.self, from: data)
        else { return .failure(.invalidData) }
        
        return .success(json)
    }
}
