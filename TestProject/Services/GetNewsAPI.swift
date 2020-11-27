//
//  GetNewsAPI.swift
//  TestProject
//
//  Created by Sahil Behl on 2020-11-23.
//  Copyright © 2020 sahil. All rights reserved.
//

import Foundation

class GetNewsAPI {
    let networkingLayer: NetworkingLayer = NetworkingLayer.shared
    let baseURL: String = "https://hacker-news.firebaseio.com/v0"
    
    func fetchTopStoryIds(failure: ((Error) -> Void)?, success: (([Int]) -> Void)?) {
        guard let url = URL(string: baseURL + "/topstories.json") else {
            failure?(NSError(domain: "Inccorect url", code: 0, userInfo: nil))
            return
        }
        
        networkingLayer.makeRequest(to: url, failure: {
            failure?($0)
            return
        }, success: { data in
            do {
                let ids = try JSONDecoder().decode([Int].self, from: data)
                success?(ids)
            } catch {
                failure?(NSError(domain: "Error", code: 0, userInfo: nil))
            }
        })
    }
    
    func fetchNews(failure: ((Error) -> Void)?, success: (([News]) -> Void)?) {
        let dispatchGroup = DispatchGroup()
        fetchTopStoryIds(failure: failure, success: { ids in
            var newsArray = [News]()
            for id in ids {
                dispatchGroup.enter()
                guard let url = URL(string: self.baseURL + "/item/\(id).json") else {
                    dispatchGroup.leave()
                    failure?(NSError(domain: "Inccorect url", code: 0, userInfo: nil))
                    return
                }

                self.networkingLayer.makeRequest(to: url, failure: {
                    dispatchGroup.leave()
                    failure?($0)
                    return
                }, success: { data in
                    do {
                        let news = try JSONDecoder().decode(News.self, from: data)
                        newsArray.append(news)
                        dispatchGroup.leave()
                    } catch {
                        failure?(NSError(domain: "Error", code: 0, userInfo: nil))
                        dispatchGroup.leave()
                    }
                    
                })
            }
            dispatchGroup.notify(queue: .main) {
                success?(newsArray)
            }
        })
    }
}
