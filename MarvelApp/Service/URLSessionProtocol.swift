//
//  URLSessionProtocol.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 7/3/21.
//

import Foundation

//sourcery: AutoMockable
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}
