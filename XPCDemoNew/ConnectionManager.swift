//
//  ConnectionManager.swift
//  XPCDemoNew
//
//  Created by Angelos Staboulis on 18/1/25.
//

import Foundation
let xpcServiceLabel = "com.template.XPCService"

@objc protocol XPCServiceProtocol
{
    
    func startTimer() -> Void
    
    func cancelTimer() -> Void
    
}

@objc protocol ClientProtocol
{
    
    func createRandomNumber() 
}
class ConnectionManager: NSObject, ObservableObject, ClientProtocol
{
    
    private var _connection: NSXPCConnection!
    
    @Published var message : String = "0"
    
    
    private func establishConnection() -> Void
    {
        _connection = NSXPCConnection(serviceName: xpcServiceLabel)
        
        _connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        
        _connection.exportedObject = self
        _connection.exportedInterface = NSXPCInterface(with: ClientProtocol.self)
        
        _connection.interruptionHandler = {
            
            NSLog("connection to XPC service has been interrupted")
        }
        
        _connection.invalidationHandler = {
            
            NSLog("connection to XPC service has been invalidated")
            self._connection = nil
        }
        
        _connection.resume()
        
        NSLog("successfully connected to XPC service")
    }
    
    
    public func xpcService() -> XPCServiceProtocol
    {
        
        if _connection == nil {
            NSLog("no connection to XPC service")
            establishConnection()
        }
        
        return _connection.remoteObjectProxyWithErrorHandler { err in
            print(err)
        } as! XPCServiceProtocol
    }
    
    
    func invalidateConnection() -> Void
    {
        guard _connection != nil else { NSLog("no connection to invalidate"); return }
        
        _connection.invalidate()
    }
    

    func createRandomNumber()
    {
           
        DispatchQueue.main.async {
            let randomNumber = Int.random(in: 0...100000)
            self.message = String(randomNumber)
        }
           
    }

}
