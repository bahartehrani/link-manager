//
//  UIGrid.swift
//  Grid iOS 13 Demo
//
//  Created by Karan Pal on 30/06/20.
//  Copyright © 2020 Swift Pal. All rights reserved.
//

import SwiftUI

struct UIGrid<Content: View, T: Hashable>: View {
    
    private let columns: Int
    private var list: [[T]] = []
    private let content: (T) -> Content
    
    init(columns: Int, list: [T], @ViewBuilder content:@escaping (T) -> Content) {
        self.columns = columns
        self.content = content
        self.setupList(list)
    }
    
    private mutating func setupList(_ list: [T]) {
        var column = 0
        var columnIndex = 0
        
        for object in list {
            if columnIndex < self.columns {
                if columnIndex == 0 {
                    self.list.insert([object], at: column)
                    columnIndex += 1
                }else {
                    self.list[column].append(object)
                    columnIndex += 1
                }
            }else {
                column += 1
                self.list.insert([object], at: column)
                columnIndex = 1
            }
        }
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.list.count, id: \.self) { i  in
                HStack {
                    ForEach(self.list[i], id: \.self) { object in
                        
                            self.content(object)
                                .frame(width: UIScreen.main.bounds.size.width/CGFloat(Double(self.columns) + 0.25))
                    }
                }
            }
            
        }
    }
}

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    @State var title: String = "Enter a folder name..."
    @Binding var folders: [Folder]

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(self.isShowing)
                VStack {
                    TextField(self.title, text: self.$text)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .id(self.isShowing)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                                
                            }
                        }) {
                            Text("Dismiss")
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                if let _ = self.folders.firstIndex(of: Folder(name: self.text)) {
                                    self.text = ""
                                    self.title = "Enter a folder name not already taken..."
                                } else {
                                    self.folders.append(Folder(name: self.text))
                                    self.isShowing.toggle()
                                }
                            }
                        }) {
                            Text("Save")
                        }
                        
                    }
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}

extension View {

    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        folders: Binding<[Folder]>) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       folders: folders)
    }

}
