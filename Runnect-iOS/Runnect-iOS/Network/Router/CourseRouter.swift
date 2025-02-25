//
//  CourseRouter.swift
//  Runnect-iOS
//
//  Created by sejin on 2023/02/16.
//

import Foundation

import Moya

enum CourseRouter {
    case uploadCourseDrawing(param: CourseDrawingRequestDto)
    case getAllPrivateCourse
    case getPrivateCourseNotUploaded
    case getCourseDetail(courseId: Int)
    case deleteCourse(courseIdList: [Int])
}

extension CourseRouter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .uploadCourseDrawing:
            return "/course"
        case .getAllPrivateCourse:
            return "/course/user"
        case .getPrivateCourseNotUploaded:
            return "/course/private/user"
        case .getCourseDetail(let courseId):
            return "/course/detail/\(courseId)"
        case .deleteCourse:
            return "/course"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadCourseDrawing:
            return .post
        case .getAllPrivateCourse, .getPrivateCourseNotUploaded, .getCourseDetail:
            return .get
        case .deleteCourse:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .uploadCourseDrawing(let param):
            var multipartFormData: [MultipartFormData] = []
            
            let imageData = MultipartFormData(provider: .data(param.image),
                                              name: "image", fileName: "image.jpeg",
                                              mimeType: "image/jpeg")
            
            multipartFormData.append(imageData)
            
            var content = [String: Any]()
            
            var path = [[String: Any]]()
            
            do {
                for location in param.data.path {
                    let locationData = try location.asParameter()
                    path.append(locationData)
                }

                content["path"] = path
                content["distance"] = param.data.distance
                content["departureAddress"] = param.data.departureAddress
                content["departureName"] = param.data.departureName
                
                let jsonData = try JSONSerialization.data(withJSONObject: content)
                let formData = MultipartFormData(provider: .data(jsonData), name: "data", mimeType: "application/json")
                multipartFormData.append(formData)
            } catch {
                print(error.localizedDescription)
            }
            
            return .uploadMultipart(multipartFormData)
        case .deleteCourse(let courseIdList):
            return .requestParameters(parameters: ["courseIdList": courseIdList], encoding: JSONEncoding.default)
        case .getAllPrivateCourse, .getPrivateCourseNotUploaded, .getCourseDetail:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .uploadCourseDrawing:
            return ["Content-Type": "multipart/form-data"]
        default:
            return Config.defaultHeader
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
