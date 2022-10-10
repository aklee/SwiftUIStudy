//
//  EmptyPublisherView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/5.
//

import SwiftUI
import Combine

//Empty
//Empty不会发送任何内容，当订阅后立刻发送complete事件。
//
//Fail
//Fail不会发送任何内容，当订阅后立刻发送指定Error。
//

struct EmptyPublisherView: View {
    var body: some View {
        Text("Hello, World!").onAppear {
            Empty<Int, Never>().sink { e in
                print("completion", e)
            } receiveValue: { d in
                print("value", d)
            }
//            completion finished
            
            Fail(error: NSError(domain: "aaa", code: 111, userInfo: [:])).sink { e in
                print("completion", e)
            } receiveValue: { d in
                print("value", d)
            }
            
//            completion failure(Error Domain=aaa Code=111 "(null)")
            
            
            (0 ..< 5).publisher.sink { e in
                print("completion", e)
            } receiveValue: { d in
                print("value", d)
            }
//            value 0
//            value 1
//            value 2
//            value 3
//            value 4
//            completion finished
        }
    }
}

struct EmptyPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPublisherView()
    }
}
