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
    
    public func createBot(name:String, completion:(success: Bool, bot: Bot?) -> ()){
        
//        let repoKey = "9BD5C6759E9559DB9E18EF779411E6F5C408EFAC"
//        let projectOrWorkspace = "ModCloth-iOS-app.xcworkspace"
//        let schemeName = "ModCloth-iOS-app"
//        let copyPath = "ModCloth-iOS-app/"
//        let gitUrl = "git@github.com:modcloth/ModCloth-iOS-app.git"
//        let workspaceBlueprintIdentifierKey = "551110DD-FF0D-472B-B35D-43E1296709AD"
//        let branch = "development"
        
        let repoKey = "02F8B173E21F34661050884F2631F2E55D63254D"
        let projectOrWorkspace = "MobileStyle.xcodeproj"
        let schemeName = "MobileStyle"
        let copyPath = "mc-mobile-style/"
        let gitUrl = "git@github.com:modcloth/mc-mobile-style.git"
        let workspaceBlueprintIdentifierKey = "16835A9F-FFFA-4D41-8EEA-45BD6B9944C0"
        let branch = "master"
        
        
        let group = ["name":"DC7151C9-B8A9-46CB-80D6-365EC296FACA"]
        let sourceControlBlueprint = [
            "DVTSourceControlWorkspaceBlueprintLocationsKey":[
                repoKey:[
                    "DVTSourceControlBranchIdentifierKey":branch,
                    "DVTSourceControlBranchOptionsKey":156,
                    "DVTSourceControlWorkspaceBlueprintLocationTypeKey":"DVTSourceControlBranch"
                ]
            ],
            "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey":repoKey,
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey":[
                repoKey:[
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryUsernameKey":"git",
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey":privateKey,
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey":"DVTSourceControlSSHKeysAuthenticationStrategy",
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryPublicKeyDataKey":publicKey,
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryPasswordKey":""
                ]
            ],
            "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey":[
                repoKey:0
            ],
            "DVTSourceControlWorkspaceBlueprintIdentifierKey":workspaceBlueprintIdentifierKey,
            "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey":[
                repoKey:copyPath
            ],
            "DVTSourceControlWorkspaceBlueprintNameKey":schemeName,
            "DVTSourceControlWorkspaceBlueprintVersion":203,
            "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey":projectOrWorkspace,
            "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey":[
                [
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey":gitUrl,
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey":"com.apple.dt.Xcode.sourcecontrol.Git",
                    "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey":repoKey
                ]
            ]
        ]
        
        println(sourceControlBlueprint)
        
        let params = [
            "group": group,
            "configuration": [
                "builtFromClean":1,
                "testingDeviceIDs": ["eb5383447a7bfedad16f6cd86300aaa2"],
                "triggers":[
                    ["phase":2,
                        "scriptBody":"",
                        "type":2,
                        "name":"Notify Committers on Failure",
                        "conditions":[
                            "status":2,
                            "onWarnings":false,
                            "onBuildErrors":true,
                            "onInternalErrors":false,
                            "onAnalyzerWarnings":false,
                            "onFailingTests":false,
                            "onSuccess":false],
                        "emailConfiguration":[
                            "includeCommitMessages":true,
                            "additionalRecipients":[],
                            "emailCommitters":true,
                            "includeIssueDetails":true]
                    ]
                ],
                "periodicScheduleInterval":0,
                "performsTestAction":false,
                "performsAnalyzeAction":false,
                "schemeName":schemeName,
                "weeklyScheduleDay":0,
                "minutesAfterHourToIntegrate":0,
                "sourceControlBlueprint": sourceControlBlueprint,
                "hourOfIntegration":0,
                "scheduleType":3,
                "performsArchiveAction":true,
                "testingDestinationType":3
            ],
            "requiresUpgrade":false,
            "name":name,
            "type":1
        ]
        
        Alamofire.request(.POST, "https://\(self.address):\(self.port)/api/bots", parameters: params, encoding: .JSON)
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
        
        Alamofire.request(.GET, "https://\(self.address):\(self.port)\(deviceListString)")
            .authenticate(user: user, password: password)
            .responseJSON { (request, response, jsonOptional, error) in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let devices = devicesFromDevicesJson(json)
                    completion(devices)
                }
        }
    }
    
    public func fetchBots(completion:([Bot]) -> () ) {
        Alamofire.request(.GET, "https://\(self.address):\(self.port)/api/bots")
            .authenticate(user: user, password: password)
            .responseJSON { (request, response, jsonOptional, error) in
                
                if let json = jsonOptional as? Dictionary<String, AnyObject> {
                    let bots = botsFromBotsJson(json, self)
                    completion(bots)
                }
        }
    }
}