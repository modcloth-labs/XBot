//
//  Device.swift
//  XBot
//
//  Created by Geoffrey Nix on 9/30/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation

public class Device {
    public var id:String
    public var name:String
    public var osVersion:String
    public var type:String
    
    public init(deviceDictionary:NSDictionary){
        id = deviceDictionary["_id"]! as! String
        name = deviceDictionary["name"]! as! String
        osVersion = deviceDictionary["osVersion"]! as! String
        type = deviceDictionary["deviceType"]! as! String
    }
    
    public func description() -> String {
        return "\(type) \(name) (\(id)) \(osVersion)"
    }
    
}


func devicesFromDevicesJson(json:Dictionary<String, AnyObject>) -> [Device] {
    var devices:[Device] = []
    if let results = json["results"] as AnyObject? as? [Dictionary<String, AnyObject>]{
        for dict in results {
            devices.append(Device(deviceDictionary: dict))
        }
    }
    
    return devices
}