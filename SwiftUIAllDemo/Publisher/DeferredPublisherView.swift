//
//  DeferredPublisherView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/5.
//

import SwiftUI
import Combine
//这个是延时创建Publisher,当被订阅的时候才会创建Publisher。
struct DeferredPublisherView: View {
    var body: some View {
        Text("Hello, World!").onAppear {
            let date = Date()
            var store = Set<AnyCancellable>()
            let publisher = Deferred { () -> Just<Int> in
                print("Create Publisher", 0 - date.timeIntervalSinceNow)
                return Just(1)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
                print("Subscribe", 0 - date.timeIntervalSinceNow)
                publisher.sink { event in
                    print("complete \(event)", 0 - date.timeIntervalSinceNow)
                } receiveValue: { value in
                    print("value \(value)", 0 - date.timeIntervalSinceNow)
                }.store(in: &store)
            }
            print("Run ", 0 - date.timeIntervalSinceNow)
        }
    }
}
//
//Run  0.00010907649993896484
//Subscribe 3.000316023826599
//Create Publisher 3.000532031059265
//value 1 3.000640034675598
//complete finished 3.0007150173187256

struct DeferredPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        DeferredPublisherView()
    }
}
