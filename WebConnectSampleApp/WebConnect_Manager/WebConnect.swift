//
//  WebConnect_Manager.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/2/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit

class WebConnect: NSObject {
    

   class func get() -> Builder.GetBuilder{
    
        return Builder.GetBuilder(type: "GET")
    }
    
    class func post() -> Builder.PostBuilder{
        return Builder.PostBuilder(type: "POST")
    }
    
    class func put() -> Builder.PutBuilder{
        return Builder.PutBuilder(type: "PUT")
    }

    class func delete() -> Builder.DeleteBuilder{
        return Builder.DeleteBuilder(type: "DELETE")
    }
    
    class func patch() -> Builder.PatchBuilder{
        return Builder.PatchBuilder(type: "PATCH")
    }
    
    class func download(fileName :String) -> Builder.DownloadBuilder{
       return Builder.DownloadBuilder(type: "GET", fileName: fileName)
    }
    
    class func uploadPost() -> Builder.UploadBuilder{
        return Builder.UploadBuilder(type: "POST")
    }
    
    class func uploadPut() -> Builder.UploadBuilder{
        return Builder.UploadBuilder(type: "PUT")
    }
}
