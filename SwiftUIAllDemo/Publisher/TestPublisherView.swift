//
//  TestPublisherView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/5.
//

import SwiftUI
import Combine

class TestPublisher: Publisher {
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
        subscriber.receive(1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            subscriber.receive(2)
            subscriber.receive(completion: .finished)
        }
    }
    
    typealias Output = Int
    
    typealias Failure = Never
    
}

struct TestPublisherView: View {
    @State var store = Set<AnyCancellable>()
    var body: some View {
        Button("Tap me") {
            let testPublisher = TestPublisher()
            testPublisher.sink { event in
                print("completion1 \(event)")
            } receiveValue: { result in
                print("value1 \(result)")
            }

            testPublisher.sink { event in
                print("completion2 \(event)")
            } receiveValue: { result in
                print("value2 \(result)")
            }.store(in: &store)

        }
    }
}
//value1 1
//value2 1
//value1 2
//completion1 finished
//value2 2
//completion2 finished

struct TestPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        TestPublisherView()
    }
}
