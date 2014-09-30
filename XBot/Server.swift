//
//  Server.swift
//  XBot
//
//  Created by Geoffrey Nix on 9/30/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation
import Alamofire

public class Server {
    public let address = "10.3.10.64"
    public let port = "20343"
    public let user = "xcode_bot"
    public let password = "Disco1990"
    
    public init() {
        
    }
    
    public func fetchDevices(completion:([Device]) -> () ) {
        let deviceListString = "/api/devices"
        
        Alamofire.request(.GET, "https://\(self.address):\(self.port)\(deviceListString)")
            .authenticate(user: user, password: password)
            .responseJSON { (request, response, jsonOptional, error) -> Void in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let devices = devicesFromDevicesJson(json)
                    completion(devices)
                }
        }
    }
}