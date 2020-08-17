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
    @State var showAddLink = false
    
    @State var newLinkName : String = ""
    @State var newLinkLink : String = ""
    
    @Binding var uid : String
    @Binding var folders : [Folder]
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "arrowshape.turn.up.left")
                    .font(.system(size: 24))
                    .onTapGesture {
                        withAnimation {
                            self.showFolderView = false
                        }
                }
                
                Spacer()
                
                
                Image(systemName: "plus.circle")
                    .font(.system(size: 24))
                    .onTapGesture(perform: {
                        self.showAddLink.toggle()
                    }
                    )
                
            }.padding(.vertical,24)
            .padding(.horizontal,36)
            
            List(selectedFolder.links) { link in
                VStack {
                    Text(link.name)
                    
                    Text(link.link)
                }
            }
        }.textFieldAlertMultiLine(isShowing: self.$showAddLink, textName: self.$newLinkName, textLink: self.$newLinkLink, selectedFolder: self.$selectedFolder, uid: self.$uid, folders: self.$folders)
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView(showFolderView: .constant(true))
//    }
//}
