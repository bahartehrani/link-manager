//
//  FoldersViewModel.swift
//  link-manager
//
//  Created by Productivity on 8/17/20.
//

import Foundation
import Firebase

class FoldersViewModel: ObservableObject {
    @Published var folders = [Folder]()
    @Published var uid = ""
  
  private var db = Firestore.firestore()
    
        func fetchData() {
            Auth.auth().signInAnonymously() { (authResult, error) in
                guard let user = authResult?.user else { return }
                _ = user.isAnonymous  // true
                self.uid = user.uid
                print(self.uid)
                
                Firestore.firestore().collection("users").document(self.uid).setData([
                    "uid" : self.uid
                ],merge:true)
                
                Firestore.firestore().collection("users").document(self.uid).addSnapshotListener { (doc,error) in
                    if let err = error {
                        print(err)
                    } else {
                        let directFolderData = doc?.get("folders") as? [String : [String]] ?? [:]
                        
                        print(directFolderData)
                        if directFolderData == [:] {
                            Firestore.firestore().collection("users").document(self.uid).setData([
                                "folders" : [:]
                            ],merge:true)
                        }
                        
                        self.folders = []
                        
                        for (fName,folderLinks) in directFolderData {
                            
                            var folderClassLinks : [Link] = []
                            
                            for linkTotal in folderLinks {
                                let component_link = linkTotal.components(separatedBy: ",")
                                let link = Link(name: component_link[0], link: component_link[1])
                                
                                folderClassLinks.append(link)
                            }
                            self.folders.append(Folder(name: fName, links: folderClassLinks))
                        }
                        
                        print(self.folders)
                        
                    }
                
                }
            }
            
            
        }
    
    }


