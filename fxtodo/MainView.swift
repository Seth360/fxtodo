import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var showCompletedTasks = false
    
    var body: some View {
        HStack(spacing: 16) {
            // 左侧日历视图
            CalendarView()
                .frame(width: 350)
            
            // 右侧待办事项列表
            TodoListView(viewModel: viewModel)
                .frame(maxWidth: .infinity)
        }
        .padding(16)
        .frame(minWidth: 1000, minHeight: 600)
        .background(Color(hex: "#F5F7F9").opacity(0.5))
    }
}

#Preview {
    MainView()
} 