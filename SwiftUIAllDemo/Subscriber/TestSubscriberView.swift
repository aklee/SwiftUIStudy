//
//  TestSubscriberView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/6.
//

import SwiftUI
import Combine

//接受的事件数量等于 subscription.request的次数加上func receive(_ input: Int) -> Subscribers.Demand返回的次数和。

//sink(receiveCompletion:receiveValue:)一订阅成功就马上请求的无限个数据, 返回的Cancellable对象必须持有，否则Cancellable被释放，数据流就会被取消。
//如果不需要处理完成或者错误可以使用sink(receiveValue: )这个方法。
//

class TestSubscriber: Subscriber {
    func receive(subscription: Subscription) {
        print("receive subscription")
        subscription.request(.max(1)) //可以收到value变化回调
        
        //subscription.request(.none) //不能收到value变化回调
        //receive subscription
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("receive value ", input)
        //        return .max(2) //每次收到value时候，还可以收到2次请求
        //        输出为
        //        receive subscription
        //        receive value  0
        //        receive value  1
        //        receive value  2
        //        receive value  3
        //        receive value  4
        
        
        return input == 0 ? .max(2) : .none //收到第一次value=0后， 后续只能再收到2次变化请求
        //        receive subscription
        //        receive value  0
        //        receive value  1
        //        receive value  2
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("receive completion")
    }
    
    typealias Input = Int
    
    typealias Failure = Never
    
}

struct TestSubscriberView: View {
    @State var store = Set<AnyCancellable>()
    var body: some View {
        Text("Hello, World!").onAppear {
            // Case 1
            let sub = TestSubscriber()
            (0 ..< 5).publisher.receive(subscriber: sub)
            
            
            // Case 2
//            assgin会将接受到的数据分发(assign)给标记成发布者的属性(Property)进行重新发布。
//            assgin可以通过keypath或者inout把接受到的数据分配给属性(Property)。举个例子:
            let test = TestAssign()
            Just(1).assign(to: \.i, on: test)
            Just(5).assign(to: &test.$ii)
            test.$i.sink { event in
                print("completion1 \(event)")
            } receiveValue: { value in
                print("value1 \(value)")
            }.store(in: &store)
            test.$ii.sink { event in
                print("completion2 \(event)")
            } receiveValue: { value in
                print("value2 \(value)")
            }.store(in: &store)
            
//            value1 1
//            value2 5
            
//    变量i和ii需要使用@Published属性修饰, @Published就标记这些属性是Published,
//    通过$来获取属性对应publisher。@Published修饰的属性在SwiftUI开发中比较常用, 是连接View和ViewModel的很好方式。
        }
    }
}

class TestAssign {
    @Published var i: Int = 0
    @Published var ii: Int = 0
}

struct TestSubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        TestSubscriberView()
    }
}
