//
//  ContentView.swift
//  link-manager
//
//  Created by Productivity on 8/16/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var createFolderPopUp = false
    @ObservedObject var foldersViewModel = FoldersViewModel()
    @State var folders : [Folder] = []
    
    //@State var folders : [Folder] = [Folder(name: "test1"),Folder(name: "test2"),Folder(name: "test3"),Folder(name: "test4")]
    
    @State var newFolderName : String = ""
    @State var didSaveNewFolder : Bool = false
    
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
                
                UIGrid(columns: 2, list: self.foldersViewModel.folders) { folder in
                    
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
                    
            }.blur(radius: self.createFolderPopUp ? 16 : 0)
        }
            .onAppear() {
                self.foldersViewModel.fetchData()
            }
        .textFieldAlert(isShowing: self.$createFolderPopUp, text: self.$newFolderName, folders: self.$folders, uid: self.foldersViewModel.uid)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
