//
//  LecturesService.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/21.
//

import Foundation

protocol LecturesService {
    typealias Result = Swift.Result<LecturesResponse, LecturesServiceAPI.Error>

    func load(completion: @escaping (Result) -> Void)
}

final class LecturesServiceAPI: LecturesService {

    typealias Result = LecturesService.Result
    
    private let url: URL
    private let client: HTTPClient
    
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
                completion(LectureResponseMapper.map(data: data, response: response))
                
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }

}
