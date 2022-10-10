//
//  SubjectView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/6.
//

import SwiftUI
import Combine


//Subject提供了几个 send 方法：
//
//send(_ :Output): 用于发送一个事件给Subscriber
//send(subscription: Subscription): 发布订阅内容给发布者
struct SubjectView: View {
    @State var store = Set<AnyCancellable>()
    var body: some View {
        Text("Hello, World!").onAppear {
//        Swift 提供了PassthroughSubject和CurrentValueSubject两个Subject使用。
//        PassthroughSubject: 直接发布事件给Subscriber
            // Case 1
            let sub1 = PassthroughSubject<Int, Never>()
            sub1.sink { event in
                print("completion1 \(event)")
            } receiveValue: { result in
                print("value1 \(result)")
            }.store(in: &store)
            sub1.send(1)
            sub1.send(2)
            sub1.send(completion: .finished)
//            value1 1
//            value1 2
//            completion1 finished
            
//            CurrentValueSubject:
//            初始化一个Output类型的值并发布给Subscriber，每当发布一个事件给Subscriber，这个值就会随之更新。
//            或者更新该值也会发布事件给Subscriber。
            //Case 2
            let currentValue = CurrentValueSubject<Int, Never>(10)
            currentValue.sink { event in
                print("completion2 \(event)")
            } receiveValue: { result in
                print("value2 \(result)")
            }.store(in: &store)
            currentValue.send(3)
            currentValue.value = 4
//            value2 10
//            value2 3
//            value2 4
            
            
//            使用 eraseToAnyPublisher 将 Publisher 转换为AnyPublisher来隐藏Publihser细节。
            //Case 3
            let sub2 = PassthroughSubject<Int, Never>()
            let sub3 = sub2.eraseToAnyPublisher()//AnyPublisher<Int, Never>
            
            //当 cancel 后Subscriber就无法收到数据了。
            //Case 4
            let sub5 = PassthroughSubject<Int, Never>()
            let subscriber = TestSubscriber2()
            sub5.receive(subscriber: subscriber)
            sub5.send(10)
            sub5.send(11)
            subscriber.cancel()
            sub5.send(12)
            sub5.send(13)
            
//            receive subscription
//            receive value  10
//            receive value  11
            
            //Case 5
            let sub6 = PassthroughSubject<Int, Never>()
            let subscriber2 = TestSubscriber2()
            //sub6.receive(subscriber: subscriber2)//same
            sub6.subscribe(subscriber2)//same
                
                    
            sub6.send(20)
            sub6.send(21)
            let c = subscriber.cancellable()
            //可以外部持有c，如self.c = c, 一旦释放c，就会结束订阅、主题、发布者的关系链，并释放资源
            sub6.send(22)
            sub6.send(23)
            
//            receive subscription
//            receive value  20
//            receive value  21
//            receive value  22
//            receive value  23
            
             //akak
            let input = PassthroughSubject<Int, Never>()
            let output = PassthroughSubject<Int, Never>()
            
            let sub = input.map { value in
                return value * 2
            }//.subscribe(output)
            sub.sink(receiveValue: {
                print("Output: ", $0, self)
            }).store(in: &store)
            
            input.send(1)
            input.send(2)
            input.send(3)
            
            
            
        }
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView()
    }
}

class TestSubscriber2: Subscriber {
    private var subscription: Subscription?
    func receive(subscription: Subscription) {
        print("receive subscription")
        subscription.request(.max(1)) //可以收到value变化
        self.subscription = subscription
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("receive value ", input)
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("receive completion")
    }
    
    func cancel() {
        self.subscription?.cancel()
    }
    
    //外部通过持有AnyCancellable实例对象来控制pipline的生命周期， 一旦AnyCancellable实例被释放，就会执行内部的闭包，从而释放资源
    func cancellable() -> AnyCancellable {
        return AnyCancellable {
            self.cancel()
            print("cancel")
        }
        //AnyCancellable是一个 final class, 当 class 被释放了会调用改类的cancel()取消操作。
    }
    typealias Input = Int
    
    typealias Failure = Never
    
}

