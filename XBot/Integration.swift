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

    public var analyzerWarningCount:NSNumber = 0
    public var errorCount:NSNumber = 0
    public var testFailureCount:NSNumber = 0
    public var warningCount:NSNumber = 0

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

        if let summary = latestDictionary["buildResultSummary"] as AnyObject? as Dictionary<String, NSNumber>? {
            analyzerWarningCount = summary["analyzerWarningCount"]!
            errorCount = summary["errorCount"]!
            testFailureCount = summary["testFailureCount"]!
            warningCount = summary["warningCount"]!
        }

    }

    public var summaryString:String {
        get {
            return "Xbot Integration Results:\nErrors: \(errorCount)\nWarnings: \(warningCount)\nAnalyzerWarnings: \(analyzerWarningCount)\nTestFailures: \(testFailureCount)"
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