//
//  ContentView.swift
//  Task Group
//
//  Created by Paulo Antonelli on 25/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var goToScreen: String?
    
    fileprivate func goToScreen(withPath path: String?) -> Void {
        self.goToScreen = path
    }
    
    var body: some View {
        VStack {
            if goToScreen == nil {
                VStack {
                    Image(systemName: "lasso.and.sparkles")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Button("Task Example View".uppercased()) {
                        self.goToScreen(withPath: "TaskExampleView")
                    }.padding()
                    Button("Dispatch Example View".uppercased()) {
                        self.goToScreen(withPath: "DispatchExampleView")
                    }.padding()
                }
            }
            if goToScreen == "TaskExampleView" {
                TaskExampleView {
                    self.goToScreen(withPath: nil)
                }
            }
            if goToScreen == "DispatchExampleView" {
                DispatchExampleView {
                    self.goToScreen(withPath: nil)
                }
            }
        }
    }
}
