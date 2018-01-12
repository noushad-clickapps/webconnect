//
//  WebParam.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/3/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit

class WebParam: NSObject {
    
    var url : String = ""
    var baseUrl : String = ""
    var header = Dictionary<String, String>()
    var queryParam = Dictionary<String, String>()
    var bodyParam = Dictionary<String, String>()
    var callback:Callback?
    var tag = 0
    var connectTimeOut = 60
    var readTimeOut = 60
    var loader:UIActivityIndicatorView!
    var type = String()
    
}
