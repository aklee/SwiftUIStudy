//
//  RecordPublisherView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/5.
//

import SwiftUI
import Combine

//Record可以先用Record.Recording来记录一系列事件，稍后在通过Record发送给订阅者。
struct RecordPublisherView: View {
    var body: some View {
        Text("Hello, World!").onAppear {
            var recording = Record<Int, Never>.Recording()
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+1, execute: {
                let publisher = Record<Int, Never>(recording: recording)
                publisher.sink { event in
                    print("completion1 \(event)")
                } receiveValue: { value in
                    print("value1 \(value)")
                }
            })
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+3, execute: {
                let publisher = Record<Int, Never>(recording: recording)
                publisher.sink { event in
                    print("completion2 \(event)")
                } receiveValue: { value in
                    print("value2 \(value)")
                }
            })
            
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+5, execute: {
                let publisher = Record<Int, Never>(recording: recording)
                publisher.sink { event in
                    print("completion3 \(event)")
                } receiveValue: { value in
                    print("value3 \(value)")
                }
            })
            recording.receive(1)
            recording.receive(2)
            recording.receive(completion: .finished)
            //共用一个Recording记录了发送1，2和finish事件。创建3个Record来发布Recording的内容。
        }
    }
}

//value1 1
//value1 2
//completion1 finished
//value2 1
//value2 2
//completion2 finished
//value3 1
//value3 2
//completion3 finished


struct RecordPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        RecordPublisherView()
    }
}
