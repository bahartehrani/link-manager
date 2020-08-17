//
//  ContentView.swift
//  link-manager
//
//  Created by Productivity on 8/16/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var foldersViewModel = FoldersViewModel()
    
    @State var showFolderView = false
    @State var selectedFolder : Folder = Folder(name: "", links: [])
    
    var body : some View {
        
        Group {
            if !self.showFolderView {
                MainView(showFolderView: self.$showFolderView, uid: self.$foldersViewModel.uid, folders: self.$foldersViewModel.folders, selectedFolder: self.$selectedFolder)
            }
            else {
                FolderView(showFolderView: self.$showFolderView, selectedFolder: self.$selectedFolder, uid: self.$foldersViewModel.uid, folders: self.$foldersViewModel.folders)
            }
        }.onAppear() {
            
            self.foldersViewModel.fetchData()
            print(self.foldersViewModel.uid)
            
            print("appeared")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
