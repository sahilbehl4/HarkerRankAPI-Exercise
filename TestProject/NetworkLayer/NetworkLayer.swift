//
//  NetworkLayer.swift
//  TestProject
//
//  Created by Sahil Behl on 2020-11-22.
//  Copyright © 2020 sahil. All rights reserved.
//

import Foundation

class NetworkingLayer {
    
    private init() {}
    
    static let shared = NetworkingLayer()
    
    private let session = URLSession.shared

    func makeRequest(to url: URL, failure: ((Error) -> Void)?, success: ((Data) -> Void)?) {
        let request = URLRequest(url: url)
        let urlSession = session.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                failure?(error)
                return
            }
            
            guard let data = data else {
                failure?(NSError(domain: "Error", code: 0, userInfo: nil))
                return
            }
            
            success?(data)
        })
        urlSession.resume()
    }
}
