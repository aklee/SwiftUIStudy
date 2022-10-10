//
//  TimerView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/4.
//

import SwiftUI

struct TimerView: View {
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var counter: Int = 0
    var body: some View {
        Text("\(counter)")
            .onReceive(timer) { output in
                print(output) //2022-09-04 10:05:58 +0000
//                counter += 1
                counter = counter % 5
                counter = counter + 1
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
