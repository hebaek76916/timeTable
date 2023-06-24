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

struct LecturesResponse: Decodable {
    let items: [Item]?
    let count, scannedCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case count = "Count"
        case scannedCount = "ScannedCount"
    }
}

struct Item: Decodable {
    let dayofweek: [Dayofweek]?
    let code, location, lecture, professor: String?
    
    let startTime: String?
    let endTime: String?
    
    init(dayofweek: [Dayofweek]?, code: String?, location: String?, lecture: String?, professor: String?, startTime: String?, endTime: String?) {
        self.dayofweek = dayofweek
        self.code = code
        self.location = location
        self.lecture = lecture
        self.professor = professor
        self.startTime = startTime
        
        self.endTime = endTime
    }
    
    
    var start: Date? {
        guard let startTime else { return nil }
        return DateFormatter.toDate(startTime)
    }
    
    var end: Date? {
        guard let endTime else { return nil }
        return DateFormatter.toDate(endTime)
    }
    
    var totalMinutes: Int {
        guard
            let start,
            let end
        else { return 0 }
        return start.minuteDiff(end)
    }
    
    enum CodingKeys: String, CodingKey {
        case dayofweek, code, location, lecture, professor
        case startTime = "start_time"
        case endTime = "end_time"
    }
    
    enum Dayofweek: String, Decodable {
        case 월, 화, 수, 목, 금, 토, 일

        var weekDay: WeekDay {
            switch self {
            case .월 : return .mon
            case .화 : return .tue
            case .수 : return .wed
            case .목 : return .thu
            case .금 : return .fri
            case .토 : return .sat
            case .일 : return .sun
            }
        }
    }
}

enum LectureResponseMapper {
    
    private static var statusCode200: Int { return 200 }
    
    static func map(data: Data, response: HTTPURLResponse) -> LecturesService.Result {
        guard
            response.statusCode == statusCode200
        else { return .failure(.invalidStatusCode) }

        guard
            let json = try? JSONDecoder().decode(LecturesResponse.self, from: data)
        else { return .failure(.invalidData) }
        
        return .success(json)
        
    }
}
