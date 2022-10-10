//
//  AlertView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/4.
//

import SwiftUI

struct AlertView: View {
    @State var show1 = false
    @State var show2 = false
    @State var show3 = false
    var body: some View {
        VStack(spacing: 25) {
            Text("Alert Only OK")
                .onTapGesture {
                    show1.toggle()
                }
            Text("Alert Cancel + OK")
                .onTapGesture {
                    show2.toggle()
                }
            Text("Alert 3 Item")
                .onTapGesture {
                    show3.toggle()
                }
                
        }
        .alert("Hello", isPresented: $show1) {
            HStack {
                Button("OK") {
                    print("OK")
                }
            }
        }
        .alert("Hello2", isPresented: $show2) {
            HStack {
                Button("OK") {
                    print("OK")
                }
                Button("Cancel") {
                    print("Cancel")
                }
            }
        }
        .alert("Hello3", isPresented: $show3) {
            VStack {//按钮个数是有限制的，大概十几个。否则报错
                Button("OK") {
                    print("OK")
                }
                Button("OK2") {
                    print("OK2")
                }
                Button("Cancel") {
                    print("Cancel")
                }
            }
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
