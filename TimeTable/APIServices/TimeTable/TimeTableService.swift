//
//  TimeTableService.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import Foundation

protocol TimeTableService {

    typealias Result = Swift.Result<TimeTableResponse, LecturesServiceAPI.Error>

    func load(completion: @escaping (Result) -> Void)
    
    func send(code: String, body: [String: Any], completion: @escaping (Bool) -> Void)
    
    func omit(code: String, completion: @escaping (Bool) -> Void)

}

final class TimeTableServiceAPI: TimeTableService {
    
    typealias Result = TimeTableService.Result
    
    private let url: URL
    private let client: HTTPClient
    
    private var body: [String: Any] = [:]
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidStatusCode
        case invalidData
    }
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(TimeTableResponseMapper.map(data: data, response: response))
                
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    func send(code: String, body: [String: Any], completion: @escaping (Bool) -> Void) {
        client.post(from: url, body: body) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                completion(true)
                
            case .failure:
                completion(false)
            }
            
        }
    }
    
    func omit(code: String, completion: @escaping (Bool) -> Void) {
        
    }

}
