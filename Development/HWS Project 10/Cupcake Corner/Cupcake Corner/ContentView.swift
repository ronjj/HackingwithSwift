//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Ronald Jabouin on 1/15/21.
//

import SwiftUI
    
struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types [$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.specialRequestEnabled .animation()){
                        Text("Any special requests")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("add extra sprinkles")
                        }
                    }
                    
                    Section {
                        NavigationLink(destination: AddressView(order: order)) {
                            Text("Delivery details")
                        }
                    }
                }
                
            }
            
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
