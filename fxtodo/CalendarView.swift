import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    
    private let calendar = Calendar.current
    private let weekdays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    
    var body: some View {
        VStack(spacing: 28) {
            // 月份选择器
            HStack {
                Text("\(yearMonth)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(hex: "#333333"))
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: { changeMonth(by: -1) }) {
                        Image("previous")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    
                    Button(action: { changeMonth(by: 1) }) {
                        Image("next")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
            }
            
            VStack(spacing: 16) {
                // 星期标题
                HStack(spacing: 0) {
                    ForEach(weekdays, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(hex: "#333333"))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // 日历网格
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                    ForEach(daysInMonth(), id: \.self) { day in
                        if day > 0 {
                            Button(action: {
                                selectDate(day: day)
                            }) {
                                if isCurrentDay(day) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(hex: "#FB3F4A"))
                                            .frame(width: 24, height: 24)
                                        
                                        Text("\(day)")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                    }
                                } else {
                                    Text("\(day)")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(Color(hex: "#666666"))
                                }
                            }
                            .frame(height: 24)
                        } else {
                            Text("")
                                .frame(height: 24)
                        }
                    }
                }
                
                Divider()
                    .background(Color(hex: "#F7F7F7"))
                    .frame(height: 0.5)
                
                // 优先级标签
                VStack(alignment: .leading, spacing: 4) {
                    Text("优先级")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#666666"))
                    
                    HStack(spacing: 8) {
                        ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                            PriorityTag(priority: priority)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // 类型标签
                VStack(alignment: .leading, spacing: 4) {
                    Text("类型")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#666666"))
                    
                    HStack(spacing: 8) {
                        ForEach(TodoItem.TaskType.allCases.prefix(3), id: \.self) { type in
                            TypeTag(type: type)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
    }
    
    private var yearMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月"
        return formatter.string(from: currentDate)
    }
    
    private func daysInMonth() -> [Int] {
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let firstDay = calendar.component(.weekday, from: startOfMonth()) - 2
        
        var days = Array(repeating: 0, count: firstDay < 0 ? 6 : firstDay)
        days.append(contentsOf: 1...range.count)
        
        // 确保总数是7的倍数
        while days.count % 7 != 0 {
            days.append(0)
        }
        
        return days
    }
    
    private func startOfMonth() -> Date {
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }
    
    private func isCurrentDay(_ day: Int) -> Bool {
        let today = calendar.dateComponents([.day, .month, .year], from: Date())
        let currentMonthYear = calendar.dateComponents([.month, .year], from: currentDate)
        
        return day == today.day && 
               currentMonthYear.month == today.month && 
               currentMonthYear.year == today.year
    }
    
    private func selectDate(day: Int) {
        var components = calendar.dateComponents([.year, .month], from: currentDate)
        components.day = day
        selectedDate = calendar.date(from: components)
    }
    
    private func changeMonth(by amount: Int) {
        if let newDate = calendar.date(byAdding: .month, value: amount, to: currentDate) {
            currentDate = newDate
        }
    }
}

struct PriorityTag: View {
    let priority: TodoItem.Priority
    
    var body: some View {
        Text(priority.rawValue)
            .font(.system(size: 12))
            .foregroundColor(Color(hex: priority.color))
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Color(hex: priority.backgroundColor))
            .cornerRadius(4)
    }
}

struct TypeTag: View {
    let type: TodoItem.TaskType
    
    var body: some View {
        Text(type.rawValue)
            .font(.system(size: 12))
            .foregroundColor(Color(hex: type.color))
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Color(hex: type.backgroundColor))
            .cornerRadius(4)
    }
}

// 颜色扩展，用于支持十六进制颜色
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    CalendarView()
        .frame(width: 350)
} 