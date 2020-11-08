//
//  Extension+URL.swift
//  sampleAPI
//
//  Created by kazuya on 2020/11/07.
//

import Foundation
import UIKit

/**
 https://qiita.com/KosukeOhmura/items/8b65bdb63da6df95c7a3
 */
extension URL {
    func queryItemAdded(name: String, value: String?) -> URL? {
        return self.queryItemsAdded([URLQueryItem(name: name, value: value)])
    }
    
    func queryItemsAdded(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: nil != self.baseURL) else {
            return nil
        }
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url
    }
}
