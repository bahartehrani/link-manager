//
//  ContentView.swift
//  link-manager
//
//  Created by Productivity on 8/16/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var createFolderPopUp = false
    //@State var folders : [Folder] = []
    
    @State var folders : [Folder] = [Folder(name: "test1"),Folder(name: "test2"),Folder(name: "test3"),Folder(name: "test4"),Folder(name: "test5"),Folder(name: "test6"),Folder(name: "test7")]
    
    var body: some View {
        VStack {
            HStack {
                Text("link manager")
                    .font(.system(size: 24, weight: .semibold))
                
                Spacer()
                
                Image(systemName: "plus.circle")
                    .font(.system(size: 24))
                    .onTapGesture(perform: {
                        self.createFolderPopUp.toggle()
                    }
                    )
            }.padding(.vertical,24)
            .padding(.horizontal,36)
            
            ScrollView(.vertical) {
                
                UIGrid(columns: 2, list: folders) { folder in
                    
                    Image(systemName: "folder")
                        .resizable()
                        .font(.system(size: UIScreen.main.bounds.width / 3))
                    .overlay(
                        Text(folder.name)
                            .padding(.top,8)
                    )
                        .padding(.horizontal)
                        .padding(.vertical,24)
                        
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
