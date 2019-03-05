//
//  URLSession+Ext.swift
//  EasyLogin
//
//  Created by Vinh on 3/3/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case head = "HEAD"
}

protocol Request {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension String: Request {
    var url: URL { return URL(string: self)! }
    var method: HTTPMethod { return .get }
    var headers: [String : String]? { return nil }
    var parameters: [String : String]? { return nil }
}

extension URLSession {
    
    @discardableResult
    func requestJSON(with request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: prepareUrlRequest(from: request), completionHandler: completionHandler)
        task.resume()
        return task
    }
    
    @discardableResult
    func requestJSON<T: Decodable>(with request: Request, completionHandler: @escaping (T?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: self.prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(json, error)
                } catch {
                    completionHandler(nil, error)
                }
            } else {
                completionHandler(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func requestJSON<T: Decodable>(with request: Request, completionHandler: @escaping ([T]?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: self.prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode([T].self, from: data)
                    completionHandler(json, error)
                } catch {
                    completionHandler(nil, error)
                }
            } else {
                completionHandler(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func requestJSON(with request: Request, completionHandler: @escaping (Any?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: prepareUrlRequest(from: request)) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(json, error)
                } catch {
                    completionHandler(nil, error)
                }
            } else {
                completionHandler(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    private func prepareUrlRequest(from request: Request) -> URLRequest {
        guard var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create url components from url: \(request.url.absoluteString)")
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.parameters?.forEach{ (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("Couldn't create url with these parameters")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers?.forEach{ (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
