//
//  FuturePublisherView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/5.
//

import SwiftUI
import Combine

//未来某个时刻会发出一个事件然后就结束。
struct FuturePublisherView: View {
    @State var future: Future<Int, Never>?
    @State var store = Set<AnyCancellable>()
    var body: some View {
        Text("Hello").onAppear {
        
//Future<Int, Never>: Int表示Publisher的Output类型, Never是Failure类型，Never表示不会发生错误。构造函数里的promise参数用来成功或者失败发送事件。
            self.future = Future<Int, Never> { promise in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    promise(.success(1))
                }
            }
            
            self.future!.sink { event in
                print("completion \(event)")
            } receiveValue: { value in
                print("value \(value)")
            }
            .store(in: &store)//必须有store，否则sink会不生效，pipline被断开

        }
    }
}

//value 1
//completion finished

struct FuturePublisherView_Previews: PreviewProvider {
    static var previews: some View {
        FuturePublisherView()
    }
}
