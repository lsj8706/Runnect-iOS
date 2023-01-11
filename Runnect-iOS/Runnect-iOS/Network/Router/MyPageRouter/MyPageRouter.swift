//
//  MyPageRouter.swift
//  Runnect-iOS
//
//  Created by 몽이 누나 on 2023/01/10.
//

import Foundation

import Moya

enum MyPageRouter {
    case getMyPageInfo
    case getUploadedCourseInfo
}

extension MyPageRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .getMyPageInfo:
            return "/user"
        case .getUploadedCourseInfo:
            return "/public-course/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageInfo:
            return .get
        case .getUploadedCourseInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageInfo:
            return .requestPlain
        case .getUploadedCourseInfo:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getMyPageInfo:
            return ["Content-Type": "application/json",
                    "machineId": "1"]
        case .getUploadedCourseInfo:
            return ["Content-Type": "application/json",
                    "machineId": "1"]
        }
    }
}