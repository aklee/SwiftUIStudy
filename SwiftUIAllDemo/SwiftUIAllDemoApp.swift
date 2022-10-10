//
//  SwiftUIAllDemoApp.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/3.
//

import SwiftUI

@main
struct SwiftUIAllDemoApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("applicationDidFinishLaunching launchOptions:\(String(describing: launchOptions))")
        return true
    }
}
