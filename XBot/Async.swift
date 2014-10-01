//
//  Async.swift
//  xbot
//
//  Created by Geoffrey Nix on 9/26/14.
//  Copyright (c) 2014 ModCloth. All rights reserved.
//

import Foundation

public func waitUntil(inout finished:Bool, timeout:NSTimeInterval) {
    let timeoutDate = NSDate(timeInterval: timeout, sinceDate: NSDate())
    do {
        NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: timeoutDate);
        if timeoutDate.timeIntervalSinceNow < 0.0 {
            println("Timeout!!!")
            break
        }
    } while (!finished);
}