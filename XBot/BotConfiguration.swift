//
//  BotConfiguration.swift
//  XBot
//
//  Created by Geoffrey Nix on 10/1/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation


public class BotConfiguration {
    public var name:String
    public var projectOrWorkspace:String
    public var schemeName:String
    public var gitUrl:String
    public var branch:String
    public var publicKey:String
    public var privateKey:String
    public var deviceIds:[String]
    
    public var performsTestAction:Bool = false
    public var performsAnalyzeAction:Bool = false
    public var performsArchiveAction:Bool = false
    
    var repoKey:String = NSUUID().UUIDString
        .stringByReplacingOccurrencesOfString("-", withString: "", options: nil, range: nil)
        .stringByAppendingString("1234ABCD")
    var group:String = NSUUID().UUIDString
    var workspaceBlueprintIdentifierKey:String = NSUUID().UUIDString
    var copyPath:String {
        get {
            return self.schemeName.stringByAppendingString("/")
        }
    }
    
    public init(
        name:String,
        projectOrWorkspace:String,
        schemeName:String,
        gitUrl:String,
        branch:String,
        publicKey:String,
        privateKey:String,
        deviceIds:[String]
        ) {
            
        self.name = name
        self.projectOrWorkspace = projectOrWorkspace
        self.schemeName = schemeName
        self.gitUrl = gitUrl
        self.branch = branch
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.deviceIds = deviceIds
    }
    
    var groupDictionaryRepresentation:NSDictionary {
        get {
            return ["name":group]
        }
    }
    
    var sourceControlBlueprintDictionaryRepresentation:NSDictionary {
        get {
            return [
                "DVTSourceControlWorkspaceBlueprintLocationsKey":[
                    self.repoKey:[
                        "DVTSourceControlBranchIdentifierKey":self.branch,
                        "DVTSourceControlBranchOptionsKey":156,
                        "DVTSourceControlWorkspaceBlueprintLocationTypeKey":"DVTSourceControlBranch"
                    ]
                ],
                "DVTSourceControlWorkspaceBlueprintPrimaryRemoteRepositoryKey":self.repoKey,
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey":[
                    self.repoKey:[
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryUsernameKey":"git",
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationStrategiesKey":self.privateKey,
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryAuthenticationTypeKey":"DVTSourceControlSSHKeysAuthenticationStrategy",
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryPublicKeyDataKey":self.publicKey,
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryPasswordKey":""
                    ]
                ],
                "DVTSourceControlWorkspaceBlueprintWorkingCopyStatesKey":[
                    self.repoKey:0
                ],
                "DVTSourceControlWorkspaceBlueprintIdentifierKey":self.workspaceBlueprintIdentifierKey,
                "DVTSourceControlWorkspaceBlueprintWorkingCopyPathsKey":[
                    self.repoKey:self.copyPath
                ],
                "DVTSourceControlWorkspaceBlueprintNameKey":self.schemeName,
                "DVTSourceControlWorkspaceBlueprintVersion":203,
                "DVTSourceControlWorkspaceBlueprintRelativePathToProjectKey":self.projectOrWorkspace,
                "DVTSourceControlWorkspaceBlueprintRemoteRepositoriesKey":[
                    [
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryURLKey":self.gitUrl,
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositorySystemKey":"com.apple.dt.Xcode.sourcecontrol.Git",
                        "DVTSourceControlWorkspaceBlueprintRemoteRepositoryIdentifierKey":self.repoKey
                    ]
                ]
            ]
        }
    }
    
    public var dictionaryRepresentation:NSDictionary {
        get  {
            return [
                "group": self.groupDictionaryRepresentation,
                "configuration": [
                    "builtFromClean":1,
                    "testingDeviceIDs": self.deviceIds,
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
                                "emailCommitters":false,
                                "includeIssueDetails":true]
                        ]
                    ],
                    "periodicScheduleInterval":0,
                    "performsTestAction":self.performsTestAction,
                    "performsAnalyzeAction":self.performsAnalyzeAction,
                    "schemeName":schemeName,
                    "weeklyScheduleDay":0,
                    "minutesAfterHourToIntegrate":0,
                    "sourceControlBlueprint": self.sourceControlBlueprintDictionaryRepresentation,
                    "hourOfIntegration":0,
                    "scheduleType":3,
                    "performsArchiveAction":self.performsArchiveAction,
                    "testingDestinationType":3
                ],
                "requiresUpgrade":false,
                "name":name,
                "type":1
            ]
        }
    }
    
}