import SwiftUI

struct TodoListView: View {
    @ObservedObject var viewModel: TodoViewModel
    @State private var showNewTaskSheet = false
    
    var body: some View {
        VStack(spacing: 28) {
            // 欢迎信息和按钮
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Welcome, 石海宏.")
                        .font(.custom("Urbanist", size: 28, relativeTo: .title).weight(.semibold))
                        .foregroundColor(Color(hex: "#3F3D56"))
                    
                    Text("你有 \(viewModel.activeTodosCount) 条待办")
                        .font(.custom("Urbanist", size: 18, relativeTo: .body).weight(.medium))
                        .foregroundColor(Color(hex: "#8D9CB8"))
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    // 新建按钮
                    Button(action: {
                        showNewTaskSheet = true
                    }) {
                        HStack(spacing: 4) {
                            Image("add")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(hex: "#545861"))
                            
                            Text("新建")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#2A2A2A"))
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 32)
                        .background(Color(hex: "#F0F5F8"))
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(hex: "#E9E9E9"), lineWidth: 1)
                        )
                    }
                    
                    // AI生成按钮
                    Button(action: {
                        viewModel.generateAITodos()
                    }) {
                        HStack(spacing: 4) {
                            Image("ai")
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Text("生成待办")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#5B70EA"))
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 32)
                        .background(Color.white)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(hex: "#ACB0FA"),
                                            Color(hex: "#98CCFC"),
                                            Color(hex: "#C58EF8")
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                    }
                }
            }
            
            // 待办事项列表
            VStack(spacing: 30) {
                // 活跃的待办事项
                VStack(spacing: 20) {
                    ForEach(viewModel.filteredTodos.filter { !$0.isCompleted }) { todo in
                        TodoItemView(viewModel: viewModel, todo: todo)
                    }
                }
                
                // 已完成的待办事项
                if viewModel.showCompletedTasks && !viewModel.filteredTodos.filter({ $0.isCompleted }).isEmpty {
                    VStack(spacing: 21) {
                        HStack {
                            HStack(spacing: 10) {
                                Text("Completed")
                                    .font(.custom("Urbanist", size: 18, relativeTo: .body).weight(.semibold))
                                    .foregroundColor(Color(hex: "#8D9CB8"))
                                
                                Image("arrow")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color(hex: "#8D9CB8"))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.removeCompletedTodos()
                            }) {
                                Text("Delete all")
                                    .font(.custom("Urbanist", size: 18, relativeTo: .body).weight(.semibold))
                                    .foregroundColor(Color(hex: "#FF5E5E"))
                                    .underline(color: Color(hex: "#FFB4AB"))
                            }
                        }
                        
                        VStack(spacing: 20) {
                            ForEach(viewModel.filteredTodos.filter { $0.isCompleted }) { todo in
                                TodoItemView(viewModel: viewModel, todo: todo)
                            }
                        }
                    }
                }
            }
        }
        .padding(36)
        .background(Color.white)
        .cornerRadius(6)
        .shadow(color: Color(hex: "#AAAAAA").opacity(0.03), radius: 8, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color(hex: "#EBEBEB"), lineWidth: 0.5)
        )
        .sheet(isPresented: $showNewTaskSheet) {
            NewTaskView(viewModel: viewModel, isPresented: $showNewTaskSheet)
        }
    }
}

struct NewTaskView: View {
    @ObservedObject var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("任务信息")) {
                    TextField("任务标题", text: $viewModel.newTaskTitle)
                    
                    DatePicker("截止日期", selection: Binding(
                        get: { viewModel.selectedDate ?? Date() },
                        set: { viewModel.selectedDate = $0 }
                    ), displayedComponents: .date)
                }
                
                Section(header: Text("优先级")) {
                    Picker("优先级", selection: $viewModel.selectedPriority) {
                        ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(Color(hex: priority.color))
                                    .frame(width: 12, height: 12)
                                Text(priority.rawValue)
                            }
                            .tag(priority)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("类型")) {
                    Picker("类型", selection: $viewModel.selectedType) {
                        ForEach(TodoItem.TaskType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("新建待办")
            .navigationBarItems(
                leading: Button("取消") {
                    isPresented = false
                    viewModel.resetForm()
                },
                trailing: Button("保存") {
                    viewModel.addTodo()
                    isPresented = false
                }
                .disabled(viewModel.newTaskTitle.isEmpty)
            )
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoViewModel())
        .frame(width: 600)
} 