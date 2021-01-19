//
//  DetailView.swift
//  Bookworm
//
//  Created by Ronald Jabouin on 1/18/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment (\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    
    let book:Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "fantasy")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "no review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
            }
        }
        
        .navigationBarTitle(Text(book.title ?? "unknown book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title:Text("Delete book"), message: Text("are you sure?"), primaryButton: .destructive(Text("delete")) {self.deleteBook()}, secondaryButton: .cancel())
        }
        
        .navigationBarItems(trailing: Button(action : {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
    
    func deleteBook () {
        moc.delete(book)
        
        // try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "test book"
        book.author = "test author"
        book.genre = "fantasy"
        book.rating = 4
        book.review = "this is a great book, i really enjoyed it"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
