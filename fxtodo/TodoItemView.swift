import SwiftUI

struct TodoItemView: View {
    @ObservedObject var viewModel: TodoViewModel
    var todo: TodoItem
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.toggleCompletion(for: todo)
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(todo.isCompleted ? Color(hex: "#007FFF") : Color.clear)
                        .frame(width: 24, height: 24)
                    
                    if todo.isCompleted {
                        Image("check")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.white)
                    } else {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(hex: "#C6CFDC"), lineWidth: 2)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.custom("Urbanist", size: 18, relativeTo: .body).weight(.semibold))
                    .foregroundColor(todo.isCompleted ? Color(hex: "#8D9CB8") : Color(hex: "#3F3D56"))
                    .strikethrough(todo.isCompleted)
            }
            
            Spacer()
            
            if !todo.isCompleted {
                HStack(spacing: 10) {
                    Button(action: {
                        // 日历功能
                    }) {
                        Image("calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(hex: "#8D9CB8"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        // 标记优先级
                    }) {
                        Image("flag")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(hex: "#007FFF"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        viewModel.removeTodo(at: IndexSet([viewModel.todos.firstIndex(where: { $0.id == todo.id }) ?? 0]))
                    }) {
                        Image("delete")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(hex: "#FF5E5E"))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } else {
                Image("completed")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(hex: "#8QBWIG"))
            }
        }
        .padding(20)
        .background(Color(hex: "#F5F7F9"))
        .cornerRadius(20)
    }
}

// 预览
struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            TodoItemView(viewModel: TodoViewModel(), todo: TodoItem.sampleData[0])
            TodoItemView(viewModel: TodoViewModel(), todo: TodoItem.sampleData[1])
        }
        .padding()
        .background(Color.white)
        .previewLayout(.sizeThatFits)
    }
} 