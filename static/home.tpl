<!DOCTYPE html>
<html lang="en">
  <head>
    <title>✨ Modern Todo Manager</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }
      
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
        animation: gradientShift 15s ease infinite;
        background-size: 200% 200%;
      }

      @keyframes gradientShift {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
      }
      
      .container {
        max-width: 700px;
        margin: 40px auto;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        overflow: hidden;
        backdrop-filter: blur(10px);
        animation: slideIn 0.6s ease-out;
      }

      @keyframes slideIn {
        from {
          opacity: 0;
          transform: translateY(-30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      
      .header {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
        padding: 30px 20px;
        text-align: center;
        position: relative;
        overflow: hidden;
      }

      .header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        animation: rotate 20s linear infinite;
      }

      @keyframes rotate {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
      }
      
      .header h1 {
        font-size: 32px;
        font-weight: 700;
        letter-spacing: 1px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        position: relative;
        z-index: 1;
      }

      .header p {
        margin-top: 8px;
        font-size: 14px;
        opacity: 0.9;
        position: relative;
        z-index: 1;
      }
      
      .todo-form {
        padding: 25px;
        background: linear-gradient(to bottom, #f8f9ff 0%, white 100%);
        border-bottom: 2px solid #e0e7ff;
      }
      
      .input-group {
        display: flex;
        gap: 12px;
      }
      
      .todo-input {
        flex: 1;
        padding: 15px 20px;
        border: 3px solid #e0e7ff;
        border-radius: 12px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: white;
      }
      
      .todo-input:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        transform: translateY(-2px);
      }
      
      .todo-input.error {
        border-color: #f5576c;
        animation: shake 0.5s;
      }

      @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-10px); }
        75% { transform: translateX(10px); }
      }
      
      .btn {
        padding: 15px 30px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
      }

      .btn:active {
        transform: translateY(0);
      }
      
      .btn-add {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
      }
      
      .btn-edit {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
      }
      
      .btn-small {
        padding: 8px 16px;
        font-size: 12px;
        margin: 0 3px;
        border-radius: 8px;
      }
      
      .btn-success {
        background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        color: white;
      }
      
      .btn-danger {
        background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
        color: white;
      }
      
      .todo-list {
        list-style: none;
        max-height: 500px;
        overflow-y: auto;
      }

      .todo-list::-webkit-scrollbar {
        width: 8px;
      }

      .todo-list::-webkit-scrollbar-track {
        background: #f1f1f1;
      }

      .todo-list::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 4px;
      }
      
      .todo-item {
        padding: 18px 25px;
        border-bottom: 1px solid #f0f0f0;
        display: flex;
        align-items: center;
        justify-content: space-between;
        cursor: pointer;
        transition: all 0.3s ease;
        animation: fadeIn 0.4s ease-out;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateX(-20px);
        }
        to {
          opacity: 1;
          transform: translateX(0);
        }
      }
      
      .todo-item:hover {
        background: linear-gradient(to right, #f8f9ff 0%, #fff 100%);
        transform: translateX(5px);
        box-shadow: inset 4px 0 0 #667eea;
      }
      
      .todo-item.completed {
        background: linear-gradient(to right, #e8f5e9 0%, #f1f8f4 100%);
        opacity: 0.7;
      }

      .todo-item.completed:hover {
        opacity: 1;
      }
      
      .todo-text {
        flex: 1;
        margin-left: 15px;
        font-size: 16px;
        color: #333;
        font-weight: 500;
      }
      
      .todo-text.completed {
        text-decoration: line-through;
        color: #999;
      }
      
      .todo-checkbox {
        width: 22px;
        height: 22px;
        cursor: pointer;
        accent-color: #667eea;
      }
      
      .todo-actions {
        display: flex;
        gap: 6px;
      }
      
      .empty-state {
        padding: 60px 20px;
        text-align: center;
        color: #999;
      }

      .empty-state::before {
        content: '📝';
        display: block;
        font-size: 64px;
        margin-bottom: 20px;
        animation: bounce 2s infinite;
      }

      @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
      }

      .empty-state p {
        font-size: 18px;
        font-weight: 500;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>✨ Modern Todo Manager</h1>
        <p>Organize your tasks with style</p>
      </div>
      
      <div class="todo-form">
        <form id="todoForm">
          <div class="input-group">
            <input 
              type="text" 
              id="todoInput" 
              class="todo-input" 
              placeholder="What needs to be done today? 🚀"
              autocomplete="off"
            >
            <button type="submit" id="addBtn" class="btn btn-add">➕ Add</button>
          </div>
        </form>
      </div>
      
      <ul id="todoList" class="todo-list">
        <!-- Todos will be dynamically added here -->
      </ul>
      
      <div id="emptyState" class="empty-state" style="display: none;">
        <p>No tasks yet. Start by adding one! 🎯</p>
      </div>
    </div>
    <script>
      let todos = [];
      let editingTodo = null;
      
      // DOM elements
      const todoForm = document.getElementById('todoForm');
      const todoInput = document.getElementById('todoInput');
      const addBtn = document.getElementById('addBtn');
      const todoList = document.getElementById('todoList');
      const emptyState = document.getElementById('emptyState');
      
      // Load todos when page loads
      document.addEventListener('DOMContentLoaded', function() {
        loadTodos();
      });
      
      // Form submission
      todoForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const title = todoInput.value.trim();
        
        if (title === '') {
          todoInput.classList.add('error');
          setTimeout(() => {
            todoInput.classList.remove('error');
          }, 2000);
          return;
        }
        
        if (editingTodo) {
          updateTodo(editingTodo.id, title);
        } else {
          addTodo(title);
        }
        
        todoInput.value = '';
        resetEditMode();
      });
      
      // Load todos from server
      function loadTodos() {
        fetch('/todo')
          .then(response => response.json())
          .then(data => {
            todos = data.data || [];
            renderTodos();
          })
          .catch(error => {
            console.error('Error loading todos:', error);
          });
      }
      
      // Add new todo
      function addTodo(title) {
        fetch('/todo', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ title: title })
        })
        .then(response => response.json())
        .then(data => {
          if (data.todo_id) {
            todos.push({
              id: data.todo_id,
              title: title,
              completed: false
            });
            renderTodos();
          }
        })
        .catch(error => {
          console.error('Error adding todo:', error);
        });
      }
      
      // Update todo
      function updateTodo(id, title) {
        const todo = todos.find(t => t.id === id);
        if (!todo) return;
        
        fetch(`/todo/${id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            id: id,
            title: title,
            completed: todo.completed
          })
        })
        .then(response => {
          if (response.status === 200) {
            todo.title = title;
            renderTodos();
          }
        })
        .catch(error => {
          console.error('Error updating todo:', error);
        });
      }
      
      // Toggle todo completion
      function toggleTodo(id) {
        const todoIndex = todos.findIndex(t => t.id === id);
        if (todoIndex === -1) return;
        
        const todo = todos[todoIndex];
        const newCompleted = !todo.completed;
        
        fetch(`/todo/${id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            id: id,
            title: todo.title,
            completed: newCompleted
          })
        })
        .then(response => {
          if (response.status === 200) {
            todos[todoIndex].completed = newCompleted;
            renderTodos();
          }
        })
        .catch(error => {
          console.error('Error toggling todo:', error);
        });
      }
      
      // Edit todo
      function editTodo(id) {
        const todo = todos.find(t => t.id === id);
        if (!todo) return;
        
        editingTodo = todo;
        todoInput.value = todo.title;
        addBtn.textContent = '✏️ Update';
        addBtn.className = 'btn btn-edit';
        todoInput.focus();
      }
      
      // Delete todo
      function deleteTodo(id) {
        if (!confirm('🗑️ Are you sure you want to delete this task?')) {
          return;
        }
        
        fetch(`/todo/${id}`, {
          method: 'DELETE'
        })
        .then(response => {
          if (response.status === 200) {
            todos = todos.filter(t => t.id !== id);
            renderTodos();
            resetEditMode();
          }
        })
        .catch(error => {
          console.error('Error deleting todo:', error);
        });
      }
      
      // Reset edit mode
      function resetEditMode() {
        editingTodo = null;
        addBtn.textContent = '➕ Add';
        addBtn.className = 'btn btn-add';
      }
      
      // Render todos
      function renderTodos() {
        todoList.innerHTML = '';
        
        if (todos.length === 0) {
          emptyState.style.display = 'block';
          return;
        }
        
        emptyState.style.display = 'none';
        
        todos.forEach(todo => {
          const li = document.createElement('li');
          li.className = `todo-item ${todo.completed ? 'completed' : ''}`;
          
          li.innerHTML = `
            <input 
              type="checkbox" 
              class="todo-checkbox" 
              ${todo.completed ? 'checked' : ''}
              onclick="toggleTodo('${todo.id}')"
            >
            <span class="todo-text ${todo.completed ? 'completed' : ''}">${todo.title}</span>
            <div class="todo-actions">
              <button class="btn btn-small btn-success" onclick="editTodo('${todo.id}')">✏️ Edit</button>
              <button class="btn btn-small btn-danger" onclick="deleteTodo('${todo.id}')">🗑️ Delete</button>
            </div>
          `;
          
          todoList.appendChild(li);
        });
      }
    </script>
  </body>
</html>