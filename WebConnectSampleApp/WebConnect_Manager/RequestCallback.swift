//
//  RequestCallback.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/10/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit
import Alamofire

class RequestCallback: NSObject {
    
    init(param: WebParam, request: DataRequest) {
        
        request.responseString { (response:DataResponse<String>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    if param.loader != nil && param.loader.isAnimating{
                        param.loader.stopAnimating()
                        param.loader.hidesWhenStopped = true
                    }
                    if WebConnectConfiguration.debug  {
                        print(response.result.value! as Any)
                    }
                    param.callback?.onSuccess(response: response.result.value!, tag: param.tag)
                }
                break
            case .failure(_):
                if WebConnectConfiguration.debug  {
                    print(response.result.error! as Any)
                }
                if param.loader != nil && param.loader.isAnimating{
                    param.loader.stopAnimating()
                    param.loader.hidesWhenStopped = true
                }
                param.callback?.onError(error: response.result.error as! String, tag: param.tag)
                break
            }
        }
    }
}
