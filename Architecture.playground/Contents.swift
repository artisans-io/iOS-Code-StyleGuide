import UIKit

class Database {
    
    struct OrderModel {
        let name: String
        let id: Int
    }
    
    // API
    func save(orders: [OrderModel]) { }
    
    func saveOrder(name: String, id: Int) -> OrderModel { OrderModel(name: name, id: id) }
    
    func getOrders() -> [OrderModel] {
        []
    }
}

class Networking {
    
    struct OrderAPIModel: Codable {
        let name: String
        let id: Int
    }
    
    func downloadOrders() -> [OrderAPIModel] {
        []
    }
    
    func upload(order: OrderAPIModel) { }
}

// Business logic
class SmartKit {
    let networking = Networking()
    let database = Database()
    
    func initialLoad() {
        let apiOrders: [Networking.OrderAPIModel] = networking.downloadOrders()
        let databaseOrders: [Database.OrderModel] = apiOrders.map { Database.OrderModel(name: $0.name, id: $0.id) }
    }
    
    func renameFirstOrder(name: String) {
        let firstOrder = database.getOrders().first!
        let orderDto = database.saveOrder(name: name, id: firstOrder.id)
        networking.upload(order: Networking.OrderAPIModel(name: orderDto.name, id: orderDto.id))
    }

    // Use Case: lista orderów (index, nazwa)
    func getOrders() -> [Any] {
        database.getOrders() 
    }
}

class App {
    let smartKit = SmartKit()
    
    struct OrderListItemViewModel {
        let name: String
        let typeIcon: String
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
        smartKit.getOrders()
    }
    
    var details: OrderDetailsViewModel? {
        smartKit.getOrders().first!
    }
}
// cmd ctrel e - rename w scope
