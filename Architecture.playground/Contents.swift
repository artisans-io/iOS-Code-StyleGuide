import UIKit

class SVDatabase {
    
    struct OrderModel {
        let name: String
        let id: Int
    }
    
    // API
    func save(orders: [OrderModel]) { }
    
    // USE CASE eg. rename
    //func save(order: OrderModel) -> OrderModel { }
    
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
    let database = SVDatabase()
    
    func initialLoad() {
        let apiOrders: [Networking.OrderAPIModel] = networking.downloadOrders()
        let databaseOrders: [SVDatabase.OrderModel] = apiOrders.map { SVDatabase.OrderModel(name: $0.name, id: $0.id) }
    }
    
    func renameFirstOrder(name: String) {
        let firstOrder = database.getOrders().first!
        let orderDto = database.saveOrder(name: name, id: firstOrder.id)
        networking.upload(order: Networking.OrderAPIModel(name: orderDto.name, id: orderDto.id))
    }

    struct OrderViewModel {
        let id: Int
        let name: String
        let index: String
        let isImage: Bool // UserDefaults
    }
    
    // UseCase:lista orderów (index, nazwa)
    func getOrders() -> [Any] {
        database.getOrders() 
    }
}

class Presentation {
    
    let smartKit = SmartKit()
    
    var orders: [OrderViewModel] {
        smartKit.getOrders()
    }
}
// cmd ctrel e - rename w scope
