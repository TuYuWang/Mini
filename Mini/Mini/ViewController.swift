//
//  ViewController.swift
//  Mini
//
//  Created by Mac on 2018/1/10.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let HOST = "http://127.0.0.1:8181/login"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testNetwork()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testNetwork() {
//        Alamofire.request(HOST, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            print(response)
//        }
        
        let parameter = ["userName": "tyw", "password": "12345678"]
        
        Alamofire.request(HOST, method: .post, parameters: parameter).responseJSON { (response) in
            print(response.result.value)
        }
    }
}

