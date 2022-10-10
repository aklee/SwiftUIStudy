//
//  Disclosure.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/9/4.
//

import SwiftUI

struct DisclosureView: View {
    @State var show = true
    @State var selectedColorTag = 0
    
    var body: some View {
        
        VStack{
            VStack {
                DisclosureGroup("姓名", isExpanded: $show) {
                    VStack {
                        Text("张三").onTapGesture {
                            withAnimation {
                                show.toggle()
                            }
                        }
                        Text("李四").onTapGesture {
                            withAnimation {
                                show.toggle()
                            }
                        }
                        Text("王五").onTapGesture {
                            show.toggle()
                        }
                    }
                }
                .padding()
                
                DisclosureGroup("性别") {
                    VStack {
                        Text("男")
                        Text("女")
                        Text("保密")
                    }
                    .foregroundColor(Color.red)
                }
                .padding()
                .foregroundColor(Color.orange)
                .accentColor(Color.red)
                
            }
             
            Divider()
            
            DisclosureGroup {
                Picker("Favorite Color", selection: $selectedColorTag) {
                    Text("Red").tag(0)
                    Text("Green").tag(1)
                    Text("Blue").tag(2)
                }
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(getFillColor())
                    .frame(width: 150, height: 40)
            }
            .padding()
            
            Divider()
            DisclosureSettingsView()
        }
    }
}

extension DisclosureView {
    func getFillColor() -> Color {
        switch selectedColorTag {
        case 0:
            return Color.red
        case 1:
            return Color.green
        case 2:
            return Color.blue
        default:
            return Color.black
        }
        
    }
}

struct DisclosureSettingsView: View {
   @State private var soundOn = true
   @State private var nickname = "Somebody"
   @State private var email = "my@email.com"
   @State private var foreColor = Color.red
   @State private var bgColor = Color.black
   
   
   var body: some View {
       Form {
           DisclosureGroup("Sound Settings") {
               Toggle("Enable Sounds", isOn: $soundOn)
           }
           
           DisclosureGroup("Profile Settings") {
               DisclosureGroup("Profile Name") {
                   TextField("Nickname", text: $nickname)
               }
               
               DisclosureGroup("Email Address") {
                   TextField("Email", text: $email)
               }
               
               DisclosureGroup("Colors Preferences") {
                   ColorPicker("Text Color", selection: $foreColor)
                   ColorPicker("Background Color", selection: $bgColor)
               }
           }
       }
   }
}

struct DisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureView()
    }
}
