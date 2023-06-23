//
//  LecturesResponseModel.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/21.
//

import Foundation

/*{
    "Items": [
        {
            "dayofweek": [
                "금",
                "목"
            ],
            "code": "PG1807-22",
            "location": "공학관312",
            "lecture": "웹서버프로그래밍",
            "professor": "이승X",
            "start_time": "9:00",
            "end_time": "9:50"
        },
        {
            "dayofweek": [
                "수"
            ],
            "code": "PG1807-45",
            "location": "혜인관609",
            "lecture": "국제화와무역",
            "professor": "이규X",
            "start_time": "17:00",
            "end_time": "18:00"
        }
    ]
}
*/

// MARK: - Welcome
struct LecturesResponse: Decodable {
    let items: [Item]?
    let count, scannedCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case count = "Count"
        case scannedCount = "ScannedCount"
    }
    
    // MARK: - Item
    struct Item: Decodable {
        let dayofweek: [Dayofweek]?
        let code, location, lecture, professor: String?
        
        let startTime: String?//TODO: 시간 칸 구해야됨.
        let endTime: String?//TODO: 시간 칸 구해야됨.
        
        enum CodingKeys: String, CodingKey {
            case dayofweek, code, location, lecture, professor
            case startTime = "start_time"
            case endTime = "end_time"
        }
        
        enum Dayofweek: String, Decodable {
            case 월
            case 화
            case 수
            case 목
            case 금
            case 토
            case 일
        }
    }
    
    
}

enum LectureResponseMapper {
    
    private static var statusCode200: Int { return 200 }
    
    static func map(data: Data, response: HTTPURLResponse) -> LecturesService.Result {
        guard
            response.statusCode == statusCode200
        else { return .failure(.invalidStatusCode) }

//        let str = String(data: data, encoding: .utf8)
        guard
            let json = try? JSONDecoder().decode(LecturesResponse.self, from: data)//(str?.data(using: .utf8))!)
        else { return .failure(.invalidData) }
        
        return .success(json)
        
    }
}
