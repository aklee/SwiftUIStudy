//
//  ListView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/4.
//

import SwiftUI
struct ListAttributeView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Attri 1") {
                    ListAttribute1View()
                }
                NavigationLink("Attri 2") {
                    ListAttribute2View()
                }
            }
        }
    }
}

struct ListAttribute1View: View {
    var body: some View {
        List {
            Text("Row 1")
            Text("Row 2 (separators hidden)")
                .listRowSeparator(.hidden)
            Text("Row 3")
            Text("Row 4 (separators tinted red)")
                .listRowSeparatorTint(.red)
            Text("Row 5")
            Text("Row 6 (bottom separator hidden)")
                .listRowSeparator(.hidden, edges: .bottom)
            Text("Row 7")
            Text("Row 8 (top separator tinted blue)")
                .listRowSeparatorTint(.blue, edges: .top)
            Text("Row 9")
            Text("Row 10")
        }
        .listStyle(.plain)
    }
}

struct ListAttribute2View: View {
    var body: some View {
        List {
            Section(header: Text("Section 1"), footer: Text("Section 1 - no styling")) {
                Text("Row 1")
            }
            Section(header: Text("Section 2"), footer: Text("Section 2 - section separators hidden")) {
                Text("Row 1")
            }
            .listSectionSeparator(.hidden)
            
            Section(header: Text("Section 3"), footer: Text("Section 3 - section separator tinted red")) {
                Text("Row 1")
            }
            .listSectionSeparatorTint(.red)
            
            Section(header: Text("Section 4"), footer: Text("Section 4 - section separators tinted green")) {
                Text("Row 1")
            }
            .listSectionSeparatorTint(.green, edges: [.top, .bottom])
            
            Section(header: Text("Section 5"), footer: Text("Section 5 - section separator (bottom) hidden")) {
                Text("Row 1")
            }
            .listSectionSeparator(.hidden, edges: .bottom)
            
            Section("Section 6") {
                Text("Row 1")
            }
        }
        .listStyle(.grouped) 
    }
}

struct ListAttributeView_Previews: PreviewProvider {
    static var previews: some View {
        ListAttributeView()
    }
}
