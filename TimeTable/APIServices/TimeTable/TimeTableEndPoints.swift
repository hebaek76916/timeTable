//
//  TimeTableEndPoints.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import Foundation

public enum TimeTableEndPoints {
    
    static let userKey = "27e11f571652378630245f451b23a7b4"
    /*
    GET /timetable?user_key={사용자 ID 토큰} -> user_key로 등록 했던 강의 코드를 모두 반환

    POST /timetable -> 사용자가 새로운 강의 코드를 추가합니다.

    DELETE /timetable -> 사용자의 추가된 강의 코드를 삭제합니다.
    */
    
    case getTimetable
    case timeTable(_ code: String)
//    case postLecture(code: String)
    
    public func url() -> URL {
        let urlString = URLSessionHTTPClient.baseUrlString
        let baseURL = URL(string: urlString)!
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + "/timetable"
        
        switch self {
        case .getTimetable:
            components.queryItems = [
                URLQueryItem(name: "user_key", value: TimeTableEndPoints.userKey)
            ]
            return components.url!
            
        case .timeTable:
            return components.url!
        }
    }
    
}
