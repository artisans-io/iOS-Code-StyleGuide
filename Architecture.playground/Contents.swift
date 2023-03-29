import UIKit

class Database {
    
    // Gdzie to zdefiniować?
    struct OrderModel {
        let name: String
        let id: Int
    }
    
    func insert(orders: [OrderModel]) { }
    
    func updateOrder(name: String, id: Int) -> OrderModel { OrderModel(name: name, id: id) }
    
    func getOrders() -> [OrderModel] {
        []
    }
}

class Networking {
    
    struct OrderAPIResponse: Codable {
        let name: String
        let id: Int
        let serverId: String
    }
    
    struct OrderAPIRequest: Codable {
        let name: String
        let id: Int
        let localModificationDate: Date
    }
    
    func downloadOrders() -> [OrderAPIResponse] {
        []
    }
    
    func upload(order: OrderAPIRequest) { }
}

// Business logic
class SmartKit {
    
    struct OrderListItem {
        let id: Int
        let name: String
        let type: String
    }
    
    struct OrderDetails {
        let name: String
        let type: String
        let date: Date
        let status: String
        
        var shouldBeRed: Bool {
            status == "closed"
        }
    }
    
    private let networking = Networking()
    private let database = Database()
    
    func initialLoad() {
        let apiOrders: [Networking.OrderAPIResponse] = networking.downloadOrders()
        let databaseOrders: [Database.OrderModel] = apiOrders.map { Database.OrderModel(name: $0.name, id: $0.id) }
        database.insert(orders: databaseOrders)
    }
    
    func renameOrder(name: String, id: Int) {
        let orderDto = database.updateOrder(name: name, id: id)
        
        networking.upload(order: Networking.OrderAPIRequest(
            name: orderDto.name,
            id: orderDto.id,
            localModificationDate: Date()
        ))
    }

    // Use Case: lista orderów (index, nazwa)
    func getOrders() -> [Any] {
        database.getOrders() 
    }
}

// Smart App 3
class App {
    private let smartKit = SmartKit()
    
    struct OrderListItemViewModel {
        let id: Int
        let name: String
        let type: String
        var typeIcon: String {
            type == "open"
                ? "open.png"
                : "unknown.png"
        }
    }
    
    struct OrderDetailsViewModel {
        let name: String
        let type: String
        let date: Date
        let status: String
        
        var shouldBeRed: Bool {
            status == "closed"
        }
    }
    
    var list: [OrderListItemViewModel] {
        //smartKit.getOrders()
        []
    }
    
    var details: OrderDetailsViewModel? {
        //smartKit.getOrders().first!
        nil
    }
    
    func renameFirstOrderToFoo() {
        guard let firstViewModel = list.first else {
            return
        }
        
        smartKit.renameOrder(name: "foo", id: firstViewModel.id)
    }
}

// CMD + CTRL + E - Rename w scope
// The Spotify - The Economist

/**
 Problem: Redundante modele
 - Model w SmartKit i Database będzie chyba zawsze ten sam (Safe Object) - nie widzę Use Case w którym to bym miało być inaczej. ViewModel będzie miał rzeczy per UI np stan czy publishery.
 - Niezbędne modele:
 - - VM - bo Observable
 - - API - bo Codable
 - - CD - bo CoreData
 - Safe Object nIe można zdefiniować w Database (SK -> SVDB) bo Database NIE BĘDZIE MOŻNA PODMIENIĆ
 - Czy Database musi być osobnym modułem? Chyba nie? Ale wtedy rozrasta się jego odpowiedzialność. Czy to wielki problem?
 */
