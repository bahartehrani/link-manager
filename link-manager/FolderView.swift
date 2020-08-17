//
//  FolderView.swift
//  link-manager
//
//  Created by Productivity on 8/17/20.
//

import SwiftUI

struct FolderView: View {
    
    @Binding var showFolderView : Bool
    @Binding var selectedFolder : Folder
    
    var body: some View {
        VStack {
            
            Text("Back")
                .onTapGesture {
                    self.showFolderView = false
            }
            
            List(selectedFolder.links) { link in
                VStack {
                    Text(link.name)
                    
                    Text(link.link)
                }
            }
        }
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView(showFolderView: .constant(true))
//    }
//}
