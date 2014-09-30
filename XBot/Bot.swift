//
//  Bot.swift
//  XBot
//
//  Created by Geoffrey Nix on 9/30/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation

public class Bot {
    public var id:String
    public var rev:String
    public var name:String
    
    public init(botDictionary:NSDictionary) {
        id = botDictionary["_id"]! as String
        rev = botDictionary["_rev"]! as String
        name = botDictionary["name"]! as String
    }
}