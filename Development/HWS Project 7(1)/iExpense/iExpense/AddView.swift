//
//  AddView.swift
//  iExpense
//
//  Created by Ronald Jabouin on 1/7/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var notInteger = false
    static let types = ["Business", "Personal",]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                
            }
            .navigationBarTitle("add new expense")
            .navigationBarItems(trailing:
                Button("save"){
                    if let actualAmount = Int(self.amount)
                    {
                        let item = ExpenseItem(name: self.name, type: self.type, amount:actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.notInteger = true
                        
                    }
                    
            })
            
        }
        .alert(isPresented: $notInteger) {
                      Alert(title: Text("Text Entry Error"), message: Text("Must enter a number in this field"), dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses:  Expenses())
    }
}
