//
//  HTTPClient.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/21.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    /// The completion handler can be invoked in any thread.
    ///  Clients are responsible to dispatch to appropriate threads, if needed
    @discardableResult
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}

class URLSessionHTTPClient: HTTPClient {
    
    static let baseUrlString = "https://k03c8j1o5a.execute-api.ap-northeast-2.amazonaws.com/v1/programmers"
    static let apiKey = "QJuHAX8evMY24jvpHfHQ4pHGetlk5vn8FJbk70O6"
    //https://k03c8j1o5a.execute-api.ap-northeast-2.amazonaws.com/v1/programmers/lectures
    //-H "x-api-key : QJuHAX8evMY24jvpHfHQ4pHGetlk5vn8FJbk70O6" -H "Content-Type: application/json"
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(
            URLSessionHTTPClient.apiKey,
            forHTTPHeaderField: "x-api-key"
        )
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let task = session.dataTask(with: request) { data, response, error in
            completion(Result {
                if let error {
                    throw error
                }
                
                if let data,
                   let response = response as? HTTPURLResponse
                {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            }
            )
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}
