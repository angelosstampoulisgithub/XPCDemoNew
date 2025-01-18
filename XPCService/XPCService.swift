//
//  XPCService.swift
//  XPCService
//
//  Created by Angelos Staboulis on 18/1/25.
//

import Foundation
@objc protocol ClientProtocol
{
    
    func createRandomNumber()
    
}
let xpcServiceLabel = "com.template.XPCService"

/// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
class XPCService: NSObject,NSXPCListenerDelegate, XPCServiceProtocol {
    
    var timerSource : DispatchSourceTimer?
    
    let listener : NSXPCListener
    
    var connection : NSXPCConnection?
    
    
    override init()
    {
        listener = NSXPCListener(machServiceName: xpcServiceLabel)
        
        super.init()
        
        listener.delegate = self
    }
    
    
    func start()
    {
        listener.resume()
    }
    
    
    
    func stop()
    {
        listener.suspend()
    }
    
    
    var clientApp : ClientProtocol
    {
        return connection!.remoteObjectProxyWithErrorHandler { err in
            print(err)
        } as! ClientProtocol
    }
    
    
    
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool
    {
        
        newConnection.exportedObject = self
        
        
        newConnection.exportedInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        
        
        newConnection.remoteObjectInterface = NSXPCInterface(with: ClientProtocol.self)
        
        
        newConnection.resume()
        
        
        connection = newConnection
        
        return true
    }
    
    
    // MARK: XPCServiceProtocol
    
    func startTimer()
    {
        guard timerSource == nil else { return }
        
        timerSource = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        timerSource!.schedule(deadline: DispatchTime.now(), repeating: .seconds(1))
        
        timerSource!.setEventHandler(handler: DispatchWorkItem(block: {
            self.clientApp.createRandomNumber()
        }))
        
        timerSource!.resume()
    }
    
    
    func cancelTimer()
    {
        guard timerSource != nil else { return }
        
        
        timerSource!.cancel()
        
        
        
        timerSource = nil
    }
}
