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
        
        func callback(callBack:@escaping (Bool,_ responds:String?)-> Void) -> Self  {
            param.callback = callBack
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
        
        func callback(callBack:@escaping (Bool,_ responds:String?)-> Void) -> Self  {
            param.callback = callBack
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
            else if param.type == "PATCH" {
                method = HTTPMethod.patch
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
    
    class PatchBuilder : PostBuilder{
        
        required init(type:String) {
            super.init(type: type)
        }
    }
    
    class DownloadBuilder : NSObject{
        
        var param = WebParam()
        required init(type:String, fileName: String) {
            param.type = type
            param.filePath  = fileName
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
        
        func callback(callBack:@escaping (Bool,_ responds:Any)-> Void) -> Self  {
            param.downloadCallBack = callBack
            return self
        }
        
        func progress(progress:@escaping (_ progress:Double)-> Void) -> Self  {
            param.progress = progress
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
        
        
        func connect() {
            
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
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(self.param.filePath)
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                
            }
            
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = TimeInterval(connectTimeout)
            
            let request =
                Alamofire.download(baseUrl+param.url, to: destination)
            
            if WebConnectConfiguration.debug {
                
                debugPrint(request)
            }
            request.downloadProgress { progress in
                //print("Download Progress: \(progress.fractionCompleted)")
                
                self.param.progress?(progress.fractionCompleted)
            }
            
            request.responseData { response in
                if let data = response.result.value {
                    self.param.downloadCallBack!(true,data)
                }
                else if let error = response.result.error {
                    
                    self.param.downloadCallBack!(false,error)
                }
            }
            
        }
        
    }
    
    class UploadBuilder: NSObject {
        
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
        
        func bodyParam(bodyParam:Dictionary<String, String>) -> Self  {
            param.bodyParam = bodyParam
            return self
        }
        
        func callback(callBack:@escaping (Bool,_ responds:Any)-> Void) -> Self  {
            param.callback = callBack
            return self
        }
        
        func progress(progress:@escaping (_ progress:Double)-> Void) -> Self  {
            param.uploadprogress = progress
            return self
        }
        func dataParams(dataParams:Dictionary<String,Data>) -> Self {
            param.dataParams = dataParams
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
        
        func connect() {
            
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
            
            ////upload
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = TimeInterval(connectTimeout)
            
            Alamofire.upload(
                multipartFormData: { MultipartFormData in
                    
                    for (key, value) in self.param.bodyParam {
                        MultipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                    }
                    
                    for (key, value) in self.param.dataParams {
                        MultipartFormData.append(value, withName: key)
                    }
                    
            }, to: baseUrl + self.param.url,method: .post, headers : param.header) {
                (result) in
                
                switch result {
                    
                case .success(let request,_,_):
                    
                    if WebConnectConfiguration.debug {
                        debugPrint(request)
                    }
                    
                    request.uploadProgress(closure: { (progress) in
                        
                        self.param.progress?(progress.fractionCompleted)
                    })
                    _ = RequestCallback.init(param: self.param, request: request)
                    
                case .failure(let error):
                    
                    print(error)
                    
                    break
                  
                }
            }
          
        }
        
        
    }
}
