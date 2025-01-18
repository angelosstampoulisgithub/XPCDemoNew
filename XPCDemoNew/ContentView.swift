//
//  ContentView.swift
//  XPCDemoNew
//
//  Created by Angelos Staboulis on 18/1/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var connectionManager: ConnectionManager
    var body: some View {
          VStack{
              Text(connectionManager.message).frame(width:300,height:65,alignment: .center)
              Button {
                  startTimer()
              } label: {
                  Text("Start Timer").frame(width:300,height:65,alignment: .center)
              }
              Button {
                  cancelTimer()
              } label: {
                  Text("Cancel Timer").frame(width:300,height:65,alignment: .center)
              }
              Button {
                  invalidateConnection()
              } label: {
                  Text("Invalidate Connection").frame(width:300,height:65,alignment: .center)
              }

          }
      }
      func startTimer() -> Void
      {
          connectionManager.xpcService().startTimer()
      }
      
      
      func cancelTimer() -> Void
      {
          connectionManager.xpcService().cancelTimer()
      }
      
      
      func invalidateConnection() -> Void
      {
          connectionManager.invalidateConnection()
      }
}

#Preview {
    ContentView()
}
