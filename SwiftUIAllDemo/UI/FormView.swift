//
//  FormView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/4.
//

import SwiftUI

//https://developer.apple.com/forums/thread/673128
// Form 和 VStack的区别， Form=insetGrouped的List
struct FormView: View {
    var body: some View {
        VStack {
            Text("I’m in a VStack")
            Button("Tap Me!") {
                print("Button tapped")
            }
        }
        
        Form {
            Text("I’m in a Form")
            Button("Tap Me!") {
                print("Button tapped")
            }
        }

        List {
            Text("I’m in a insetGrouped List")
            Button("Tap Me!") {
                print("Button tapped")
            }
        }.listStyle(.insetGrouped)
        
        
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
