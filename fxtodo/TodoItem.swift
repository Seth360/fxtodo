import Foundation

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date?
    var priority: Priority = .medium
    var type: TaskType = .general
    
    enum Priority: String, Codable, CaseIterable {
        case urgent = "紧急"
        case high = "高"
        case medium = "中"
        case low = "低"
        
        var color: String {
            switch self {
            case .urgent: return "#D4340F"
            case .high: return "#E19140"
            case .medium: return "#577EBA"
            case .low: return "#A99274"
            }
        }
        
        var backgroundColor: String {
            switch self {
            case .urgent: return "#FFF5F0"
            case .high: return "#FFF5E6"
            case .medium: return "#F0F9FF"
            case .low: return "#FFFCE6"
            }
        }
    }
    
    enum TaskType: String, Codable, CaseIterable {
        case security = "安全事件"
        case system = "系统警报"
        case customer = "客户需求"
        case general = "一般任务"
        
        var color: String {
            switch self {
            case .security: return "#D4340F"
            case .system: return "#E19140"
            case .customer: return "#577EBA"
            case .general: return "#666666"
            }
        }
        
        var backgroundColor: String {
            switch self {
            case .security: return "#FFF5F0"
            case .system: return "#FFF5E6"
            case .customer: return "#F0F9FF"
            case .general: return "#F5F7F9"
            }
        }
    }
    
    static var sampleData: [TodoItem] = [
        TodoItem(title: "Design use case page", isCompleted: true, dueDate: Date().addingTimeInterval(86400), priority: .high, type: .customer),
        TodoItem(title: "Test Wireframe", isCompleted: false, dueDate: Date().addingTimeInterval(172800), priority: .medium, type: .general),
        TodoItem(title: "Create new task UI flow", isCompleted: false, dueDate: Date().addingTimeInterval(259200), priority: .urgent, type: .system),
        TodoItem(title: "Collect project assets", isCompleted: false, priority: .low, type: .general),
        TodoItem(title: "Update application design", isCompleted: false, priority: .medium, type: .customer),
        TodoItem(title: "Security audit review", isCompleted: false, dueDate: Date().addingTimeInterval(86400), priority: .urgent, type: .security),
        TodoItem(title: "System performance check", isCompleted: false, priority: .high, type: .system)
    ]
} 