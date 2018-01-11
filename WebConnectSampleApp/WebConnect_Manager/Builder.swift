//
//  Builder.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/2/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit
import Alamofire


class Builder: NSObject {
    
    class GetBuilder : NSObject{
        
        private var param = WebParam()
        required init(type:String) {
            
            param.type = type
        }
        
        func url(url:String) -> Self {
            param.url = url
            return self
        }
        
        func baseUrl(baseUrl:String) -> Self {
            param.baseUrl = baseUrl
            return self
        }
        
        func header(header:Dictionary<String, String>) -> Self  {
            param.header = header
            return self
        }
        
        func queryParam(queryParam:Dictionary<String, String>) -> Self  {
            param.queryParam = queryParam
            return self
        }
        
        func callback(callback: Callback) -> Self  {
            param.callback = callback
            return self
        }
        func tag(tag: Int) -> Self  {
            param.tag = tag
            return self
        }
        
        func loader(loader: UIActivityIndicatorView) -> Self  {
            param.loader = loader
            return self
        }
        
        func timeout(connectTimeout: Int, readTimeout : Int) -> Self  {
            param.connectTimeOut = connectTimeout
            param.readTimeOut = readTimeout
            return self
        }
        
        func connect()   {
            // implement almofire code here
            
            var connectTimeout = 0
            if param.connectTimeOut != 0 {
                connectTimeout = param.connectTimeOut
            }else {
                connectTimeout = WebConnectConfiguration.connectTimeout
            }
            
            var baseUrl = ""
            if param.baseUrl != "" {
                baseUrl = param.baseUrl
            }else {
                baseUrl = WebConnectConfiguration.baseUrl
            }
            
            if param.loader != nil && !param.loader.isAnimating{
                
                param.loader.startAnimating()
            }
            
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = TimeInterval(connectTimeout)
            
            let request = Alamofire.request(baseUrl+param.url, method: .get, parameters: param.queryParam, encoding: URLEncoding.default, headers: param.header)
            
            if WebConnectConfiguration.debug  {
                debugPrint(request)
            }
          _ = RequestCallback.init(param: param, request: request) 
            
        }
    }
    
    class PostBuilder : NSObject{
        
        var param = WebParam()
        
        required init(type:String) {
            param.type = type
        }
        
        func url(url:String) -> Self {
            param.url = url
            return self
        }
        
        func baseUrl(baseUrl:String) -> Self {
            param.baseUrl = baseUrl
            return self
        }
        
        func header(header:Dictionary<String, String>) -> Self  {
            param.header = header
            return self
        }
        
        func callback(callback: Callback) -> Self  {
            param.callback = callback
            return self
        }
        func tag(tag: Int) -> Self  {
            param.tag = tag
            return self
        }
        
        func loader(loader: UIActivityIndicatorView) -> Self  {
            param.loader = loader
            return self
        }
        
        func timeout(connectTimeout: Int, readTimeout : Int) -> Self  {
            param.connectTimeOut = connectTimeout
            param.readTimeOut = readTimeout
            return self
        }
        
        func bodyParam(bodyParam:Dictionary<String, String>) -> Self  {
            param.bodyParam = bodyParam
            return self
        }
        
        func connect()   {
            
            // implement almofire code here
            
            var connectTimeout = 0
            if param.connectTimeOut != 0 {
                connectTimeout = param.connectTimeOut
            }else {
                connectTimeout = WebConnectConfiguration.connectTimeout
            }
            
            var baseUrl = ""
            if param.baseUrl != "" {
                baseUrl = param.baseUrl
            }else {
                baseUrl = WebConnectConfiguration.baseUrl
            }
            
            if param.loader != nil && !param.loader.isAnimating{
                
                param.loader.startAnimating()
            }
            
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = TimeInterval(connectTimeout)
            
            var method =  HTTPMethod.post
            
            if param.type == "POST" {
                method = HTTPMethod.post
            }
            else if param.type == "PUT" {
                method = HTTPMethod.put
            }
            else {
                method = HTTPMethod.delete
            }
            
            let request = Alamofire.request(baseUrl+param.url, method: method, parameters: param.bodyParam, encoding: URLEncoding.default, headers: param.header)
            
            if WebConnectConfiguration.debug  {
                debugPrint(request)
            }
            _ = RequestCallback.init(param: param, request: request)
        }
    }
    
    class PutBuilder : PostBuilder{
        
        required init(type:String) {
            super.init(type: type)
        }
    }
    
    class DeleteBuilder : PostBuilder{
        
        required init(type:String) {
            super.init(type: type)
        }
    }
}

