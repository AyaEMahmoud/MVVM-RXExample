//
//  ProfilesApi.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/3/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

enum SubjectsApi {
    case getSubjects
}

extension SubjectsApi: TargetType {
    
    public var baseURL: URL { return URL(string: APPURL.BaseURL)! }
    
    public var path: String {
        switch self {
        case .getSubjects:
            return APPURL.Paths.Subjects
        }
    }
    
    public var method: Moya.Method {
       switch self {
       case .getSubjects:
        return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .getSubjects:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    public var headers: [String: String]? {
        return [KeyConstants.Headers.contentType: KeyConstants.Headers.contentTypeValue]
    }
}
