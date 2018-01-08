//
//  CallBack.swift
//  WebConnectSampleApp
//
//  Created by clickapps on 1/4/18.
//  Copyright © 2018 Noushad Shah. All rights reserved.
//

import UIKit

protocol Callback {

    func onSuccess(response:String, tag:Int)
    
    func onError(error:String, tag:Int)

}
