//
//  WebParam.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/3/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit

enum MultipartKeys: String {
   case Data =  "data"
   case Keys = "keys"
   case FileName = "fileName"
   case MimeType = "mimeType"
}

class WebParam: NSObject {
    
    var url : String = ""
    var baseUrl : String = ""
    var header = Dictionary<String, String>()
    var queryParam = Dictionary<String, String>()
    var bodyParam = Dictionary<String, String>()
    var callback:((Bool,_ response:String?)-> Void)?//Callback?
    var connectTimeOut = 60
    var readTimeOut = 60
    var loader:UIActivityIndicatorView!
    var type = String()
    var filePath = String()
    var downloadCallBack: ((Bool,_ response:Any)-> Void)?
    var progress: ((_ progress:Double) -> Void)?
   // var uploadMultipartCallBack: ((Bool,_ response:Any)-> Void)?
    var uploadprogress: ((_ progress:Double) -> Void)?
    var dataParams = [AnyObject]()
    
    
    
}
