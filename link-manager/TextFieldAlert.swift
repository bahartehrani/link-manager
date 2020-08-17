//
//  TextFieldAlert.swift
//  link-manager
//
//  Created by Productivity on 8/17/20.
//

import Foundation
import SwiftUI
import Firebase

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    let presenting: Presenting
    @State var title: String = "Enter a folder name..."
    @Binding var folders: [Folder]
    @Binding var uid : String

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
                                if let _ = self.folders.firstIndex(of: Folder(name: self.text, links: [])) {
                                    self.text = ""
                                    self.title = "Enter a folder name not already taken..."
                                } else {
                                    self.folders.append(Folder(name: self.text, links: []))
                                    Firestore.firestore().collection("users").document(self.uid).setData([
                                        "folders" : Folder.toStringDict(folders: self.folders)
                                    ],merge:true)
                                    
                                    
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
                        folders: Binding<[Folder]>, uid: Binding<String>) -> some View {
        TextFieldAlert(isShowing: isShowing,
                       text: text,
                       presenting: self,
                       folders: folders, uid: uid)
    }

}


struct TextFieldAlertMultiLine<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    @Binding var textName: String
    @Binding var textLink: String
    let presenting: Presenting
    @State var titleName: String = "Link Name..."
    @State var titleLink: String = "Link Address..."
    @Binding var selectedFolder : Folder
    @Binding var uid : String
    @Binding var folders : [Folder]

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(self.isShowing)
                VStack {
                    TextField(self.titleName, text: self.$textName)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .id(self.isShowing)
                    Divider()
                    
                    TextField(self.titleLink, text: self.$textLink)
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
                                if let _ = self.selectedFolder.links.firstIndex(of: Link(name: self.textName, link: self.textLink)) {
                                    self.textLink = ""
                                    self.textName = ""
                                    self.titleName = "THIS LINK IS ALREADY ENTERED!"
                                } else {
                                    
                                    
                                    print(self.selectedFolder.links)
                                    
                                    if let idx = self.folders.firstIndex(of: Folder(name: self.selectedFolder.name, links: [])) {
                                        
                                        let linkvar = Link(name: self.textName, link: self.textLink)
                                        self.selectedFolder.links.append(linkvar)
                                        print(self.selectedFolder.links)
                                        
                                        self.folders[idx].links.append(linkvar)
                                        print(self.folders[idx].links)
                                        self.selectedFolder.links = self.folders[idx].links
                                        print("REEEE")
                                        print(self.selectedFolder.links)
                                    } 
                                    
                                    Firestore.firestore().collection("users").document(self.uid).setData([
                                        "folders" : Folder.toStringDict(folders: self.folders)
                                    ],merge:true)
                                    
                                    
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

    func textFieldAlertMultiLine(isShowing: Binding<Bool>,
                        textName: Binding<String>,
                        textLink: Binding<String>,
                        selectedFolder: Binding<Folder>, uid: Binding<String>, folders: Binding<[Folder]>) -> some View {
        TextFieldAlertMultiLine(isShowing: isShowing,
                       textName: textName,
                       textLink: textLink,
                       presenting: self,
                       selectedFolder : selectedFolder,
                       uid: uid, folders: folders)
    }

}
