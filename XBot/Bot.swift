//
//  Bot.swift
//  XBot
//
//  Created by Geoffrey Nix on 9/30/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation
import Alamofire

public class Bot {
    public var id:String
    public var rev:String
    public var name:String
    public var server:Server
    
    public init(botDictionary:NSDictionary, server:Server) {
        id = botDictionary["_id"]! as! String
        rev = botDictionary["_rev"]! as! String
        name = botDictionary["name"]! as! String
        self.server = server
    }
    
    public func fetchLatestIntegration (completion:(Integration?) -> ()) {
        Alamofire.request(.GET, "https://\(server.host):\(server.port)/api/bots/\(id)/integrations")
            .authenticate(user: server.user, password: server.password)
            .responseJSON { (request, response, jsonOptional, error) in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let integrations:[Integration]? = integrationsFromIntegrationsJson(json, self)
                    completion(integrations?.first)
                }
        }
    }
    
    public func delete(completion:(success: Bool) ->()) {
        Alamofire.request(.DELETE, "https://\(server.host):\(server.port)/api/bots/\(id)/\(rev)")
            .authenticate(user: server.user, password: server.password)
            .response { (request, response, responseData, error) in
                
                completion(success: response?.success ?? false)
        }
    }
    
    public func integrate(completion:(success: Bool, integration: Integration?) ->()) {
        Alamofire.request(.POST, "https://\(server.host):\(server.port)/api/bots/\(id)/integrations")
            .authenticate(user: server.user, password: server.password)
            .responseJSON { (request, response, jsonOptional, error)  in
                var integration:Integration?

                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    integration = Integration(latestDictionary: json, bot:self)
                }

                completion(success: response?.success ?? false, integration: integration)
        }
    }
    
}

func botsFromBotsJson(json:Dictionary<String, AnyObject>, server:Server) -> [Bot] {
    
    var bots:[Bot] = []
    if let results = json["results"] as AnyObject? as? [Dictionary<String, AnyObject>]{
        for dict in results {
            bots.append(Bot(botDictionary: dict, server:server))
        }
    }
    
    return bots
}