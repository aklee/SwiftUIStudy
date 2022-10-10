//
//  OperatorsView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/9.
//

import SwiftUI
import Combine

struct OperatorsView: View {
    @State var store = Set<AnyCancellable>()
    @State var sub: AnyCancellable?
    var body: some View {
        Text("Hello, World!").onAppear {
            //map
            _ = {
                let input = PassthroughSubject<Int, Never>()
                let output = PassthroughSubject<Int, Never>()
//                sub = input.map{$0*2}.subscribe(output)
                sub = input.subscribe(output)
                input.sink(receiveValue: {print("Receive1 ", $0)}).store(in: &store)
                output.sink(receiveValue: {print("Receive2 ", $0)}).store(in: &store)
                input.send(1)
                input.send(2)
                input.send(3)
                sub?.cancel()
            }()
            //trymap
            //mapError
            //replaceNil
            //scan
            //filter
            //tryFilter
            //compactMap
            //tryCompactMap
            //removeDuplicates
            //tryRemoveDuplicates
            //replaceEmpty
            //replaceError
            
            
            
            
            
        }
    }
}

struct OperatorsView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorsView()
    }
}
