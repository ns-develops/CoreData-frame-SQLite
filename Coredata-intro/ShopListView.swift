//
//  ShopListView.swift
//  Coredata-intro
//
//  Created by Natalie S on 2025-05-03.
//
import SwiftUI
import CoreData

struct ShopListView: View {
    @Environment(\.managedObjectContext) private var viewContext

   // @FetchRequest(
        //sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
       // predicate: NSPredicate(format: "name BEGINSWITH %@", "m"),
       // animation: .default)
    
    @FetchRequest
    private var items: FetchedResults<Item>
    
    init(filter: String) {
        if filter == "" {
            _items = FetchRequest<Item>(
                sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp,
                                                   ascending: true)]
            )
        } else {
            _items = FetchRequest<Item>(
                sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
                predicate: NSPredicate(format: "name BEGINSWITH[c] %@", filter)
                
            )
            
        }
    }
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    if let name = item.name {
                        Text(name)
                    }
                    Button(action:{}) {
                        Image(systemName: item.done ? "checkmark.square" : "square")
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
