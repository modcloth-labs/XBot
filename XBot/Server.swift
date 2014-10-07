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
    public var port:String
    public var host:String
    public var user:String
    public var password:String

    public init(host:String, user:String, password:String, port:String = "20343") {
        self.host = host
        self.user = user
        self.password = password
        self.port = port
    }
    
    public func createBot(config:BotConfiguration, completion:(success: Bool, bot: Bot?) -> ()){
        Alamofire.request(.POST, "https://\(self.host):\(self.port)/api/bots", parameters: config.dictionaryRepresentation as? [String : AnyObject], encoding: .JSON)
            .authenticate(user: user, password: password)
            .responseJSON { (request, response, jsonOptional, error) in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let bot = Bot(botDictionary: json, server: self)
                    completion(success: response?.success ?? false, bot: bot)
                } else {
                    completion(success: response?.success ?? false, bot: nil)
                }
        }
        
    }
    
    public func fetchDevices(completion:([Device]) -> () ) {
        let deviceListString = "/api/devices"
        
        Alamofire.request(.GET, "https://\(self.host):\(self.port)\(deviceListString)")
            .authenticate(user: user, password: password)
            .responseJSON { (request, response, jsonOptional, error) in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let devices = devicesFromDevicesJson(json)
                    completion(devices)
                }
        }
    }
    
    public func fetchBots(completion:([Bot]) -> () ) {
        Alamofire.request(.GET, "https://\(self.host):\(self.port)/api/bots")
            .authenticate(user: user, password: password)
            .responseJSON { (request, response, jsonOptional, error) in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let bots = botsFromBotsJson(json, self)
                    completion(bots)
                }
        }
    }
}