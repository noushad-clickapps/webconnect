//
//  ViewController.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/2/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var loaderIndicator: UIActivityIndicatorView!
    
    @IBOutlet var downLoadImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        WebConnectConfiguration().baseUrl(baseUrl: "https://reqres.in/api/")
            .debug(debug: true)
            .timeOut(connectTimeout: 20, readTimeout: 20)
            .config()
        
        WebConnect.get()
            .url(url: "offers")
            // .header(header: ["Test": "Header"])
            // .queryParam(queryParam: ["name":"Hello"])
            
            .callback(callBack: { (status, response) in
                
                if status {
                    print("Get response", response as Any)
                    
                    let jsonData = response?.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let modelData = try! decoder.decode(Model.self, from: jsonData!)
                    print("page = \(modelData.page)")
                }
                else {
                    
                }
                
            })
            .loader(loader: loaderIndicator)
          //  .connect()
        
        WebConnect.put() 
            .url(url: "users")
            .header(header: ["Test": "Header"])
            .bodyParam(bodyParam: ["name":"Amit","job":"manager"])
            .callback(callBack: { (status, response) in
                
                if status {
                  //  print("Put response", response as Any)
                }
                else {
                    
                }
            })
            .loader(loader: loaderIndicator)
          //  .connect()
        
        WebConnect.patch()
            .url(url: "users/2")
            .bodyParam(bodyParam: ["name":"Amit","job":"manager"])
            .callback { (status, response) in
                
                if status {
                      print("Patch response", response as Any)
                }
                else {
                    
                }
           
        }
        .loader(loader: loaderIndicator)
       // .connect()
        
        
        WebConnect.download(fileName:"bigImage.png")
            .url(url: "1024x1024-Wallpapers-010.jpg")
            .baseUrl(baseUrl: "http://res.cloudinary.com/clickapps/image/upload/v1504245457/test/")
            .callback(callBack: { (status, data) in
                
                if status {
                    
                    let image = UIImage(data: data as! Data)
                    
                    self.downLoadImage.image = image
                    //print("image",image)
                }
                else {
                    
                    print("downloading failed")
                    print("downloading failed \(data)")
                }
                
            })
            .progress(progress: { (progress) in
                
                print("Download Progress percentage = \(Int(progress * 100)) %")
                
            })
            //.connect()
        
        var params = [String:String]()
//        params["region_id"] = "3"
//        params["work_location_id"] = "4"
//        params["occasion_id"] = "3"
//        params["date"] = "26/01/2018"
//        params["address"] = "Chandigarh"
//        params["phone_number"] = "0512365478"
        
        params["email"] = "provider@clickapps.co"
        params["name"] = "Provider_Dev"
        params["mobile"] = "7814759012"
        
        params["locale"] = "en"
        
        let img = UIImage(named:"IMG_6169")
        let data = UIImageJPEGRepresentation(img!, 0.5)
        
        var dataParams = [String:Data]()
        dataParams["image"] =  data
        //"attachments_attributes[][attachment]\";filename=\"\(uploadDict["file_name"]!)"
        
        let headers = ["Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MywibmFtZSI6IlByb3ZpZGVyIiwiZW1haWwiOiJwcm92aWRlckBjbGlja2FwcHMuY28iLCJtb2JpbGUiOiIxMjM0NTY3IiwiaW1hZ2UiOiJkZWZhdWx0X2xvZ28uanBnIiwiYWNjZXNzIjoicHJvdmlkZXIiLCJpYXQiOjE1MjEwMjQ0MzgsImV4cCI6MTUyMzYxNjQzOH0.0iVFJfxD6B2J46zzvdsa_cZDuQu_0BnS6tgGMPVG_JI"]
        
        var dictProfileImage = [String:AnyObject]()

        dictProfileImage["data"] = UIImageJPEGRepresentation(img!, 0.5) as AnyObject?
        dictProfileImage["mimeType"] = "image/jpg" as AnyObject?
        dictProfileImage["fileName"] = "avatar_profile.jpg" as AnyObject?
        dictProfileImage["keys"] = "image" as AnyObject
        
        var arrayData = [AnyObject]()
        
        arrayData.append(dictProfileImage as AnyObject)

        
        WebConnect.upload()
            .url(url: "provider_profile?")
            .baseUrl(baseUrl: "http://api.laan.dev.clicksandbox.com:8080/v1/")
            .bodyParam(bodyParam: params )
            .header(header: headers)
            .dataParams(dataParams: arrayData)
            .callback(callBack: { (status, response) in
                
                print("upload response", response)
            })
            .progress(progress: { (progress) in
                
                print("Download Progress percentage = \(Int(progress * 100)) %")

            })
            .connect()
    }
    
    func callSomeMethodWithParams(_ params: [AnyHashable: Any], onSuccess success: @escaping (_ JSON: Any) -> Void, onFailure failure: @escaping (_ error: Error?, _ params: [AnyHashable: Any]) -> Void) {
        
        print("\n" + String(describing: params))
        
        let error: Error? = NSError(domain:"", code:1, userInfo:nil)
        
        var responseArray: [Any]?
        responseArray = [1,2,3,4,5]
        
        if let responseArr = responseArray {
            success(responseArr)
        }
        if let err = error {
            failure(err, params)
        }
        
    }
    
    
    
    
    
    
     func downLoadFile()  {
     
     let destination: DownloadRequest.DownloadFileDestination = { _, _ in
     let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     let fileURL = documentsURL.appendingPathComponent("pig.png")
     
     return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
     }
     Alamofire.download("https://httpbin.org/image/png", to: destination)
     .downloadProgress { progress in
     print("Download Progress: \(progress.fractionCompleted)")
     }
     .responseData { response in
     if let data = response.result.value {
     
     let image = UIImage(data: data)
     
     print("image",image)
     
     }
     }
     }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

