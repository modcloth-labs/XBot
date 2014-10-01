//
//  Integration.swift
//  XBot
//
//  Created by Geoffrey Nix on 9/30/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation

public class Integration {
    
    public var id:String
    public var botName:String
    public var botId:String
    public var currentStep:String
    public var result:String
    public var number:NSNumber
    
    public init(latestDictionary:NSDictionary) {
        id = latestDictionary["_id"]! as String
        botName = latestDictionary["bot"]!["name"]! as String
        botId = latestDictionary["bot"]!["_id"]! as String
        currentStep = latestDictionary["currentStep"]! as String
        number = latestDictionary["number"]! as NSNumber
        
        if let r = latestDictionary["result"] as? String {
            result = r
        } else {
            result = ""
        }
    }
}


func integrationsFromIntegrationsJson(json:Dictionary<String, AnyObject>) -> [Integration] {
    
    var integrations:[Integration] = []
    if let results = json["results"] as AnyObject? as? [Dictionary<String, AnyObject>]{
        for dict in results {
            integrations.append(Integration(latestDictionary: dict))
        }
    }
    
    return integrations
}