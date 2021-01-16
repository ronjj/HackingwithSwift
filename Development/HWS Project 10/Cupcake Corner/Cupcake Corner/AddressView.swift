//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Ronald Jabouin on 1/15/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("city", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink(destination:CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        
        .navigationBarTitle("delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
