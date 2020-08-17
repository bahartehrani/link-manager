//
//  MainView.swift
//  link-manager
//
//  Created by Productivity on 8/17/20.
//

import SwiftUI
import Firebase
import QGrid

struct MainView : View {
    
    @State var createFolderPopUp = false
    
    @Binding var showFolderView : Bool
    @Binding var uid : String
    @Binding var folders : [Folder]
    @Binding var selectedFolder : Folder
    @Binding var index : Int
    
    
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
            
//            ScrollView(.vertical) {
//
//                UIGrid(columns: 2, list: self.foldersViewModel.folders) { folder in
//
//                    Image(systemName: "folder")
//                        .resizable()
//                        .font(.system(size: UIScreen.main.bounds.width / 3))
//                        .onTapGesture {
//                            self.showFolderView.toggle()
//                            self.selectedFolder = folder
//                        }
//                    .overlay(
//                        Text(folder.name)
//                            .padding(.top,8)
//                    )
//                        .padding(.horizontal)
//                        .padding(.vertical,24)
//
//                }
//
//            }
            
            QGrid(self.folders, columns: 2) { folder in
                MiniFolderView(folder: folder)
                .onTapGesture {
                    self.showFolderView.toggle()
                    if let idx = self.folders.firstIndex(of: folder) {
                        self.index = idx
                    }
                    self.selectedFolder = folder
                }
            }.blur(radius: self.createFolderPopUp ? 20 : 0)
            
            
            
        }
            
            .textFieldAlert(isShowing: self.$createFolderPopUp, text: self.$newFolderName, folders: self.$folders, uid: self.$uid)
        
    }
    
}

struct MiniFolderView : View {
    @State var folder : Folder
    
    var body : some View {
        
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
