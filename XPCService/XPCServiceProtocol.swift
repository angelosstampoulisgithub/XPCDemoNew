//
//  XPCServiceProtocol.swift
//  XPCService
//
//  Created by Angelos Staboulis on 18/1/25.
//

import Foundation

/// The protocol that this service will vend as its API. This protocol will also need to be visible to the process hosting the service.
@objc protocol XPCServiceProtocol
  {

    func startTimer() -> Void

    func cancelTimer() -> Void

  }

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     connectionToService = NSXPCConnection(serviceName: "com.template.XPCService")
     connectionToService.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
     connectionToService.resume()

 Once you have a connection to the service, you can use it like this:

     if let proxy = connectionToService.remoteObjectProxy as? XPCServiceProtocol {
         proxy.performCalculation(firstNumber: 23, secondNumber: 19) { result in
             NSLog("Result of calculation is: \(result)")
         }
     }

 And, when you are finished with the service, clean up the connection like this:

     connectionToService.invalidate()
*/
