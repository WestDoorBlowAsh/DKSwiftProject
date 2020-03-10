//
//  DKApi.swift
//  DKSwift
//
//  Created by 邓凯 on 2019/8/30.
//  Copyright © 2019 邓凯. All rights reserved.
//

import Foundation
import Moya

enum DKApi {
    case launchAds
    case uploadFile
}

extension DKApi: TargetType {
    var baseURL: URL {
        var baseURL = URL(string: DKConst.baseURL)!
        switch self {
        case .launchAds:
            baseURL = URL(string: DKConst.baseURL + "/api/")!
        default: break
        }
        return baseURL
    }
    
    var path: String {
        var path = ""
        switch self {
        case .launchAds: path = "app/launch/ads"
        case .uploadFile: path = "upload/file"
        }
        return path
    }
    
    var method: Moya.Method {
        var method = Moya.Method.get
        switch self {
        case .uploadFile:
            method = .post
        default: break
        }
        return method
    }
    
    var task: Task {
        var task = Task.requestPlain
        switch self {
        case .launchAds: task = Task.requestPlain
        default: break
        }
        return task
    }
    
    var sampleData: Data {
        let data = "sampleData".utf8Encoded
        return data
    }
    
    var headers: [String : String]? {
        let headers: [String : String]? = nil
        return headers
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


