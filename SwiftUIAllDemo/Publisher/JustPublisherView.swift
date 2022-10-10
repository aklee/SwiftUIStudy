//
//  JustPublisherView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/5.
//

import SwiftUI
import Combine

//这是一个马上发出事件的Publisher。
struct JustPublisherView: View {
   @State var store = Set<AnyCancellable>()
    var body: some View {
        Text("Hello, World!").onAppear {
            Just(1).sink { event in
                print("completion \(event)")
            } receiveValue: { value in
                print("value \(value)")
            }.store(in: &store)
        }
    }
}
//value 1
//completion finished


struct JustPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        JustPublisherView()
    }
}
