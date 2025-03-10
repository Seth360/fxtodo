# fxtodo

一个简洁美观的待办事项管理应用，具有日历视图和任务管理功能。

![应用截图](screenshots/screenshot1.png)

## 功能特点

* **日历视图**：可以通过日历切换日期，查看不同日期的待办事项
* **待办列表**：显示当前日期的待办事项，支持添加、完成和删除操作
* **已完成列表**：显示已完成的待办事项，可以一键清空
* **生成待办**：可以随机生成待办事项，方便测试和演示
* **新建待办**：支持自定义创建新的待办事项，可设置优先级和类型

## 在线演示

访问 GitHub Pages 查看在线演示：[https://seth360.github.io/fxtodo/](https://seth360.github.io/fxtodo/)

## 一键部署

[![部署到 Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2FSeth360%2Ffxtodo)

## 使用方法

1. 克隆仓库到本地  
```  
git clone https://github.com/Seth360/fxtodo.git  
```
2. 直接在浏览器中打开 `index.html` 文件即可使用

## 项目结构

```
fxtodo/
├── index.html         # 主页面
├── bg0.png            # 背景图片
├── todo.csv           # 待办数据
├── README.md          # 项目说明
└── screenshots/       # 截图目录
```

## 技术栈

* HTML5
* CSS3
* JavaScript (原生)

## 主要功能实现

1. **日历功能**：支持月份切换，日期选择，并在切换日期时刷新待办列表
2. **待办管理**：支持添加、完成、删除待办事项
3. **数据随机**：从CSV数据源随机选择待办项，模拟真实使用场景
4. **响应式设计**：适配不同屏幕尺寸

## 贡献

欢迎提交问题和改进建议！

## 许可

MIT
