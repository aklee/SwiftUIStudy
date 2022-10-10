//
//  ContentView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/3.
//

import SwiftUI

struct HomeView: View {
//    @State var data: [String:AnyView] = [
//        "Hello": AnyView(HelloView()),
//        "Sheet": AnyView(SheetView())
//        ]
    
    @State var selection: Int? = 12
    @State var sections = [
        "UI",
        "List",
        "Publisher",     //发布者
        "Subscriber",    //订阅者
        "Subject",        //主题
        "Combine"
    ]
    @State var titles: [[String]] = [
        [
        "Hello",
        "Sheet",
        "Alert",
        "Disclosure",
        "Timer"
        ],
        [
            "List Style",
            "List Attribute",
            "List Selection"
        ],
        [
            "TestPublisher",
            "Future",
            "Just",
            "Deferred",
            "Empty",
            "Record"
        ],
        [
            "TestSubscriber"
        ],
        [
            "Subject"
        ],
        [
            "Operators",
            "Timer",
            "ImageDownloader",
            
        ]
        
        
    ]
    @State var views: [[AnyView]] = [
        [
            AnyView(HelloView()),
            AnyView(SheetView()),
            AnyView(AlertView()),
            AnyView(DisclosureView()),
            AnyView(TimerView()),
        ],
        [
            AnyView(ListStyleView()),
            AnyView(ListAttributeView()),
            AnyView(ListSelectionView()),
        ],
        [
            AnyView(TestPublisherView()),
            AnyView(FuturePublisherView()),
            AnyView(JustPublisherView()),
            AnyView(DeferredPublisherView()),
            AnyView(EmptyPublisherView()),
            AnyView(RecordPublisherView())
        ],
        [
            AnyView(TestSubscriberView()),
        ],
        [
            AnyView(SubjectView())
        ],
        [
            AnyView(OperatorsView()),
            AnyView(CombineTimerView()),
            AnyView(ImageDownloaderView()),
            
        ]
        
    ]
    var body: some View {
        NavigationView{
            List(selection: $selection) {
                ForEach(0..<sections.count, id:\.self) { idx in
//                    var sum: Int = idx*10
                    Section(sections[idx]) {
                        ForEach(0..<titles[idx].count, id:\.self) { titleIdx in
//                            let tag = idx*10 + titleIdx
                            NavigationLink(tag: idx*10 + titleIdx, selection: $selection) {
                                //destination
//                                self.views[idx][titleIdx]
//                                Text("a\(idx) \(titleIdx)  \(idx*10 + titleIdx)")
                                titles[idx][titleIdx]
                            } label: {
                                titles[idx][titleIdx]
//                                self.titles[idx][titleIdx]
//                                Text("a\(idx) \(titleIdx)  \(idx*10 + titleIdx)")
                            }

//                            NavigationLink(titles[idx][titleIdx]) {
//                                views[idx][titleIdx]
//                            }

                        }
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarTitle("参考案例")
           
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
        }
    }
}
