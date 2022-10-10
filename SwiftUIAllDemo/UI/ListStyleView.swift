//
//  ListView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/4.
//

import SwiftUI

struct ListStyleView: View {
    //    Styles:
    //    .automatic
    //    .grouped
    //    .inset
    //    .insetGrouped
    //    .plain
    //    .sidebar
     
    var body: some View {
        ScrollView{
//        VStack {
            Text("Plain")
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.green)
            List {
                ForEach(Constants.rankingTypeLists, id:\.self) { item in
                    Text("\(item)")
                }
            }
            .frame(height: 300)
            .listStyle(.plain)
            
            Text("Group")
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.green)
            List {
                Section("AAA") {
                    ForEach(Constants.rankingTypeLists, id:\.self) { item in
                        Text("\(item)")
                    }
                }
                Section("BBB") {
                    ForEach(Constants.rankingTypeLists, id:\.self) { item in
                        Text("\(item)")
                    }
                }
            }
            .frame(height: 300)
            .listStyle(.grouped)
            
            
            Text("SideBar")
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.green)
            List {
                Section("AAA") {
                    ForEach(Constants.rankingTypeLists, id:\.self) { item in
                        Text("\(item)")
                    }
                }
                Section("BBB") {
                    ForEach(Constants.rankingTypeLists, id:\.self) { item in
                        Text("\(item)")
                    }
                }
            }
            .frame(height: 300)
            .listStyle(.sidebar)
            
            
            Text("Inset")
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.green)
            List {
                ForEach(Constants.rankingTypeLists, id:\.self) { item in
                    Text("\(item)")
                }
            }
            .frame(height: 300)
            .listStyle(.inset)
            
            Text("insetGrouped")
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.green)
            List {
                ForEach(Constants.rankingTypeLists, id:\.self) { item in
                    Text("\(item)")
                }
            }
            .frame(height: 300)
            .listStyle(.insetGrouped)
        }
        .padding()
    }
}

struct ListStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleView()
    }
}
