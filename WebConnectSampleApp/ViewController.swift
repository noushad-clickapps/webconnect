//
//  ViewController.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/2/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Callback {
    
    @IBOutlet var loaderIndicator: UIActivityIndicatorView!
    
    func onSuccess(response: String, tag: Int) {
        
        print("\(response) tag \(tag)")
        let jsonData = response.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        switch(tag) {
            
        case 1:
            
            let modelData = try! decoder.decode(Model.self, from: jsonData)
            print("page = \(modelData.page)")
            break
            
        case 2:
            
            break
            
        default: break
            
        }
        
        
    }
    
    func onError(error: String, tag: Int) {
        print("\(error) tag \(tag)")
    }
    
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
            
            .callback(callback: self)
            .tag(tag: 1)
            .loader(loader: loaderIndicator)
            .connect()
        
        WebConnect.put() 
            .url(url: "users")
            .bodyParam(bodyParam: ["name":"Amit","job":"manager"])
            .tag(tag: 2)
            .loader(loader: loaderIndicator)
            .callback(callback: self)
            .connect()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

