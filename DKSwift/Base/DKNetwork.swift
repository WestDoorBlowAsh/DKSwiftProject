//
//  DKNetwork.swift
//  DKSwift
//
//  Created by 邓凯 on 2019/9/16.
//  Copyright © 2019 邓凯. All rights reserved.
//

import Foundation
import Moya

struct DKNetwork {
    
    static let ApiProvider = MoyaProvider<DKApi>()
    
    static let endPointClosure = { (target: DKApi) -> Endpoint in
        let point = Endpoint(url: target.baseURL.absoluteString, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
        return point
    }
    
    static let ApiEndPointProvider = MoyaProvider<DKApi>(endpointClosure: endPointClosure)
    
    static let SampleProvider = MoyaProvider<DKApi>(endpointClosure: MoyaProvider.defaultEndpointMapping, requestClosure: MoyaProvider<DKApi>.defaultRequestMapping, stubClosure: MoyaProvider.immediatelyStub)
    
    
    static func request(
        target: DKApi,
        success successCallback: (Any) -> Void,
        error errorCallback: (_ statusCode: Int) -> Void,
        failure failureCallback: (MoyaError) -> Void
        ) {
        
        let bag = DisposeBag()
        
        ApiProvider.rx.request(.launchAds).subscribe({ (event) in
            switch event {
            case let .success(response):
                
//                do {
//                    try response.filterSuccessfulStatusCodes()
//
//                }
                
                let data = response.data
                let statusCode = response.statusCode
                
                let dataString = String.init(data: data, encoding: String.Encoding.utf8)
                
                print("get response: \(data) \(statusCode) \(dataString)")
                
            case let .error(error):
                print("\(error)")
            }
        }).disposed(by: bag)
    }

}
