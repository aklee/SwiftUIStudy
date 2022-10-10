//
//  ListSelectionView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/10.
//

import SwiftUI
struct TempData: Identifiable {
    var id: Int
    var title: String
}

struct ListSelectionView: View {
    // handle selection nil: when detail view pushs view, selection == nil
    @State private var keepSelection: Int = 1
    // bind list selected row
    @State private var selection: Int? = 1 // set default row
    
    private var dataArr: [TempData] = [
        TempData(id: 1, title: "one"),
        TempData(id: 2, title: "two"),
        TempData(id: 3, title: "three")
    ]
    
    var body2: some View {
        List{
            VStack {
                Text("aaa")
                //当selection的值和tag相同时， 就等于点击了当前link，自动跳转到destination
                NavigationLink(tag: 1, selection: $selection) {
                    //destination
                    Text("bbb")
                } label: {
                    Text("button")
                }

            }
            
        }
    }
    var body: some View {
        List(selection: $selection) {
            ForEach(dataArr.indices) { index in
                NavigationLink(destination: Text("\(dataArr[index].title)").onAppear {
                    //跳转后会执行， 刷新值
                    keepSelection = (selection != nil ? selection! : keepSelection)
                    print("keepSelection=",keepSelection)
                }, tag: dataArr[index].id, selection: $selection) {
                    HStack {
                    Text("\(dataArr[index].title)")
                    }
                }
                .tag(dataArr[index].id) // or use enum
                .listRowBackground(keepSelection == dataArr[index].id ? Color.accentColor.cornerRadius(10.0): Color(UIColor.systemGroupedBackground).cornerRadius(10))
            }

        }
    }
}

struct ListSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListSelectionView()
    }
}
