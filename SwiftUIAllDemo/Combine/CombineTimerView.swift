//
//  CombineTimerView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/9.
//

import SwiftUI
import Combine

struct CombineTimerView: View {
    @State var store = Set<AnyCancellable>()
    var body: some View {
        Text("Hello, World!").onAppear {
            Timer.publish(every: 2, on: RunLoop.main, in: RunLoop.Mode.common)
                .autoconnect()
                .sink { d in //Output = Date
                    print(d)
                }.store(in: &store)
        }
    }
//    2022-10-09 06:34:14 +0000
//    2022-10-09 06:34:16 +0000
//    2022-10-09 06:34:18 +0000
//    2022-10-09 06:34:20 +0000
}

struct CombineTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTimerView()
    }
}
