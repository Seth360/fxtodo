//
//  fxtodoApp.swift
//  fxtodo
//
//  Created by Seth on 2025/3/5.
//

import SwiftUI

@main
struct fxtodoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
