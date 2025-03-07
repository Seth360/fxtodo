import Foundation
import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var todos: [TodoItem] = []
    @Published var newTaskTitle: String = ""
    @Published var selectedPriority: TodoItem.Priority = .medium
    @Published var selectedType: TodoItem.TaskType = .general
    @Published var selectedDate: Date? = nil
    @Published var showCompletedTasks: Bool = false
    
    var filteredTodos: [TodoItem] {
        todos.filter { todo in
            if !showCompletedTasks && todo.isCompleted {
                return false
            }
            return true
        }
    }
    
    var activeTodosCount: Int {
        todos.filter { !$0.isCompleted }.count
    }
    
    init() {
        // 加载示例数据
        todos = TodoItem.sampleData
    }
    
    func addTodo() {
        guard !newTaskTitle.isEmpty else { return }
        
        let newTodo = TodoItem(
            title: newTaskTitle,
            isCompleted: false,
            dueDate: selectedDate,
            priority: selectedPriority,
            type: selectedType
        )
        
        todos.append(newTodo)
        resetForm()
    }
    
    func resetForm() {
        newTaskTitle = ""
        selectedPriority = .medium
        selectedType = .general
        selectedDate = nil
    }
    
    func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }
    
    func removeTodo(at indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
    }
    
    func removeCompletedTodos() {
        todos.removeAll(where: { $0.isCompleted })
    }
    
    func updatePriority(for todo: TodoItem, priority: TodoItem.Priority) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].priority = priority
        }
    }
    
    func updateType(for todo: TodoItem, type: TodoItem.TaskType) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].type = type
        }
    }
    
    func updateDueDate(for todo: TodoItem, date: Date?) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].dueDate = date
        }
    }
    
    func generateAITodos() {
        // 模拟AI生成待办事项
        let aiGeneratedTodos = [
            TodoItem(title: "Review system architecture", priority: .high, type: .system),
            TodoItem(title: "Update security protocols", priority: .urgent, type: .security),
            TodoItem(title: "Prepare client presentation", priority: .medium, type: .customer)
        ]
        
        todos.append(contentsOf: aiGeneratedTodos)
    }
} 