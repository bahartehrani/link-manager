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
            var uid = ""
            Auth.auth().signInAnonymously() { (authResult, error) in
                guard let user = authResult?.user else { return }
                _ = user.isAnonymous  // true
                uid = user.uid
                print(uid)
                
                Firestore.firestore().collection("users").document(uid).setData([
                    "uid" : uid
                ],merge:true)
                
                Firestore.firestore().collection("users").document(uid).addSnapshotListener { (doc,error) in
                    if let err = error {
                        print(err)
                    } else {
                        let directFolderData = doc?.get("folders") as? [String : [String]] ?? [:]
                        
                        print(directFolderData)
                        if directFolderData == [:] {
                            Firestore.firestore().collection("users").document(uid).setData([
                                "folders" : [:]
                            ],merge:true)
                        }
                        
                        for (fName,folderLinks) in directFolderData {
                            
                            var folderClassLinks : [Link] = []
                            
                            for linkTotal in folderLinks {
                                let component_link = linkTotal.components(separatedBy: ",")
                                let link = Link(name: component_link[0], link: component_link[1])
                                
                                folderClassLinks.append(link)
                            }
                            self.folders.append(Folder(name: fName, links: folderClassLinks))
                        }
                        
                    }
                
                }
            }
            
            
        }
    
    }


