//
//  LecturesEndPoints.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/21.
//

import Foundation

public enum LecturesEndPoint {
    /*
    GET /lectures -> 전체 강의 목록을 반환합니다.

    GET /lectures?code={강의코드} -> code 값과 동일한 강의 정보가 반환됩니다.

    GET /lectures?lecture={강의이름} -> lecture로 시작하는 과목명을 모두 반환합니다. (대소문자 구분)
    */
    case lectures
    case lecturesCode(_ code: String)
    case lecturesName(_ name: String)
    
    public func url() -> URL {
        let urlString = URLSessionHTTPClient.baseUrlString
        let baseURL = URL(string: urlString)!
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + "/lectures"
        
        switch self {
        case .lectures:
            return components.url!
            
        case .lecturesCode(let code):
            components.queryItems = [
                URLQueryItem(name: "code", value: code)
            ].compactMap { $0 }
            
        case .lecturesName(let name):
            components.queryItems = [
                URLQueryItem(name: "lecture", value: "\(name)")
            ].compactMap { $0 }
        }
        
        return components.url!
    }
    
}
