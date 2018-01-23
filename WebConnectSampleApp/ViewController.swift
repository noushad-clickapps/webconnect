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
           // .connect()
        
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
            //.connect()
        
        WebConnect.download()
            .url(url: "1024x1024-Wallpapers-010.jpg")
            .baseUrl(baseUrl: "http://res.cloudinary.com/clickapps/image/upload/v1504245457/test/")
            .fileName(fileName:"bigImage.png")
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

