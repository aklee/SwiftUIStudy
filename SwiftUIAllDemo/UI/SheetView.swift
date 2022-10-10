//
//  SheetView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/3.
//

import SwiftUI
struct User: Identifiable {
    var id = "Taylor Swift"
}

struct SheetView: View {
    
    @State var show = false
    @State var chooseIdx = -1
    
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        VStack{
            Button("1 show Sheet1") {
                show.toggle()
            }
            Text("会拉起present view, 选择了\(chooseIdx)")
            
            Spacer().frame(height:20)
            
            Button("2 show Bind Sheet") {
                selectedUser = User()
                isShowingUser = true
            }
            Text("点击两次，可查看绑定信息")
        }
        .sheet(isPresented: $show) {
            print("dismiss1")
        } content: {
            List {
                ForEach(0..<100) { idx in
                    Button("\(idx)") {
                        print("choose\(idx)")
                        chooseIdx = idx
                        show.toggle()
                    }
                }
            }
        }
        .sheet(item: $selectedUser, onDismiss: {
            print("dismiss2")
        }, content: { user in
            Text(selectedUser?.id ?? "Unknown")
        })
        
        
        
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
