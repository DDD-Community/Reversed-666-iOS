//
//  ProviderProtocol.swift
//  Repository
//
//  Created by devming on 2021/09/29.
//  Copyright © 2021 com.666. All rights reserved.
//

import Moya
import Combine
import Alamofire
import Foundation

public protocol ProviderProtocol: AnyObject {
    associatedtype TargetAPI: BaseTargetType
    
    var provider: MoyaProvider<TargetAPI> { get }
    var isStub: Bool { get }
    var sampleStatusCode: Int { get }
    var customEndpointClosure: ((TargetAPI) -> Endpoint)? { get }
    
    init(isStub: Bool,
         sampleStatusCode: Int,
         customEndpointClosure: ((TargetAPI) -> Endpoint)?)
}

public extension ProviderProtocol {
    
    static func makeProvider(
        _ isStub: Bool = false,
        _ sampleStatusCode: Int = 0,
        _ customEndpointClosure: ((TargetAPI) -> Endpoint)? = nil) -> MoyaProvider<TargetAPI> {
        
        if isStub == false {
            return MoyaProvider<TargetAPI>(session: Session.default)
        } else {
            // 테스트 시에 호출되는 stub 클로져
            let endPointClosure = { (target: TargetAPI) -> Endpoint in
                let sampleResponseClosure: () -> EndpointSampleResponse = {
                    EndpointSampleResponse.networkResponse(sampleStatusCode, target.sampleData)
                }
                
                return Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: sampleResponseClosure,
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
            return MoyaProvider<TargetAPI>(
                endpointClosure: customEndpointClosure ?? endPointClosure,
                stubClosure: MoyaProvider.immediatelyStub
            )
        }
    }
}

@available(iOS 13.0, *)
public extension ProviderProtocol {
    func request<D: Decodable>(type: D.Type, atKeyPath keyPath: String? = nil, target: TargetAPI) -> AnyPublisher<D, MoyaError> {
        return provider
            .requestPublisher(target)
            .map(type, atKeyPath: keyPath)
    }
    
    func requestMock<D: Decodable>(type: D.Type, atKeyPath keyPath: String? = nil, target: TargetAPI) -> AnyPublisher<D, MoyaError> {
        return decode(target.sampleData)
    }
}