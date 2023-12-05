//
//  ContentView.swift
//  whatsapp-me
//
//  Created by arham on 03/12/23.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @EnvironmentObject private var persistentController: PersistentController
    @State private var enteredNumber: String = ""
    
    private func openWhatsApp() {
            if let url = URL(string: "https://wa.me/\(enteredNumber)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.teal
                VStack (alignment: .leading){
                    VStack (alignment:.leading) {
                        if let lists = persistentController.data {
                            List {
                                ForEach(lists, id: \.objectID) { object in
                                    Text(object.number!)
                                }
                               
                            }
                        } else {
                            Text("no data")
                        }
                        
                    }
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .listStyle(.plain)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.top,50)
                    .onAppear {
                        persistentController.fetchObjects()
                    }
                    
                    Spacer()
                    
                    Text("Go to the whatsapp \nnumber : \(enteredNumber)")
                        .foregroundColor(.white)
                    TextField("Enter the number", text: $enteredNumber)
                        .keyboardType(.numberPad)
                        .font(.system(size: 30, weight: .bold))
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        .background(.white)
                        .cornerRadius(10)
                    
                    Button("Go"){
                        
                        let newNumber = persistentController.createObject(entity: NumbersEntity.self)
                        newNumber.number = enteredNumber
                        newNumber.date = Date()
                        persistentController.fetchObjects()
                        openWhatsApp()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .background(.purple)
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                }.padding()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView().environmentObject(PersistentController.shared)
}
