<template>
  <div class="app">
    <div class="container">
      <header class="header">
        <h1>Inicio de sesión</h1>
        <p>Roy Sandoval</p>
      </header>

      <!-- Form Toggle -->
      <div class="form-toggle">
        <button 
          @click="activeForm = 'login'" 
          :class="{ active: activeForm === 'login' }"
          class="toggle-btn"
        >
          Iniciar Sesión
        </button>
        <button 
          @click="activeForm = 'register'" 
          :class="{ active: activeForm === 'register' }"
          class="toggle-btn"
        >
          Registrarse
        </button>
      </div>

      <!-- Login Form -->
      <div v-if="activeForm === 'login'" class="form-container">
        <h2>Iniciar Sesión</h2>
        
        <div v-if="loginMessage" :class="['message', loginMessageType]">
          {{ loginMessage }}
        </div>

        <form @submit.prevent="login" class="form">
          <div class="input-group">
            <label for="loginEmail">Email</label>
            <input 
              id="loginEmail"
              v-model="loginEmail" 
              type="email" 
              placeholder="usuario@ejemplo.com" 
              required 
              :disabled="loginLoading"
              class="input"
            />
          </div>

          <div class="input-group">
            <label for="loginPassword">Contraseña</label>
            <input 
              id="loginPassword"
              v-model="loginPassword" 
              type="password" 
              placeholder="Ingresa tu contraseña" 
              required 
              :disabled="loginLoading"
              class="input"
            />
          </div>

          <button type="submit" :disabled="loginLoading" class="btn btn-primary">
            <span v-if="loginLoading" class="spinner"></span>
            {{ loginLoading ? 'Iniciando sesión...' : 'Iniciar Sesión' }}
          </button>
        </form>

        <div class="test-credentials">
          <p><strong>Credenciales de prueba:</strong></p>
          <p>📧 user@test.com</p>
          <p>🔒 Test123</p>
        </div>
      </div>

      <!-- Register Form -->
      <div v-if="activeForm === 'register'" class="form-container">
        <h2>Crear Cuenta</h2>
        
        <div v-if="registerMessage" :class="['message', registerMessageType]">
          {{ registerMessage }}
        </div>

        <form @submit.prevent="register" class="form">
          <div class="input-group">
            <label for="registerEmail">Email</label>
            <input 
              id="registerEmail"
              v-model="registerEmail" 
              type="email" 
              placeholder="usuario@ejemplo.com" 
              required 
              :disabled="registerLoading"
              class="input"
            />
          </div>

          <div class="input-group">
            <label for="registerPassword">Contraseña</label>
            <input 
              id="registerPassword"
              v-model="registerPassword" 
              type="password" 
              placeholder="Mínimo 6 caracteres" 
              required 
              minlength="6"
              :disabled="registerLoading"
              class="input"
            />
            <small class="help-text">La contraseña debe tener al menos 6 caracteres</small>
          </div>

          <button type="submit" :disabled="registerLoading || !isValidPassword" class="btn btn-primary">
            <span v-if="registerLoading" class="spinner"></span>
            {{ registerLoading ? 'Registrando...' : 'Crear Cuenta' }}
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue"

// Form state
const activeForm = ref('login')

// Login form
const loginEmail = ref("")
const loginPassword = ref("")
const loginMessage = ref("")
const loginMessageType = ref("")
const loginLoading = ref(false)

// Register form
const registerEmail = ref("")
const registerPassword = ref("")
const registerMessage = ref("")
const registerMessageType = ref("")
const registerLoading = ref(false)

const API_URL = "http://localhost:8000"

// Computed properties
const isValidPassword = computed(() => {
  return registerPassword.value.length >= 6
})

// Helper functions
function clearMessages() {
  loginMessage.value = ""
  registerMessage.value = ""
}

function clearForm(type) {
  if (type === 'login') {
    loginEmail.value = ""
    loginPassword.value = ""
  } else {
    registerEmail.value = ""
    registerPassword.value = ""
  }
}

function setMessage(type, message, messageType) {
  if (type === 'login') {
    loginMessage.value = message
    loginMessageType.value = messageType
  } else {
    registerMessage.value = message
    registerMessageType.value = messageType
  }
}

// API functions
async function register() {
  if (!isValidPassword.value) {
    setMessage('register', 'La contraseña debe tener al menos 6 caracteres', 'error')
    return
  }

  registerLoading.value = true
  registerMessage.value = ""

  try {
    // Create FormData for multipart/form-data
    const formData = new FormData()
    formData.append('email', registerEmail.value)
    formData.append('password', registerPassword.value)

    const response = await fetch(`${API_URL}/registration/`, {
      method: "POST",
      body: formData
    })

    const data = await response.json()

    if (response.ok) {
      setMessage('register', '✅ ' + data.message, 'success')
      clearForm('register')
      
      // Switch to login form after successful registration
      setTimeout(() => {
        activeForm.value = 'login'
        clearMessages()
      }, 2000)
    } else {
      setMessage('register', '❌ ' + data.detail, 'error')
    }
  } catch (error) {
    console.error('Registration error:', error)
    setMessage('register', '❌ Error de conexión. Verifica que el servidor esté ejecutándose.', 'error')
  } finally {
    registerLoading.value = false
  }
}

async function login() {
  loginLoading.value = true
  loginMessage.value = ""

  try {
    // Create FormData for multipart/form-data
    const formData = new FormData()
    formData.append('email', loginEmail.value)
    formData.append('password', loginPassword.value)

    const response = await fetch(`${API_URL}/login/`, {
      method: "POST",
      body: formData
    })

    const data = await response.json()

    if (response.ok) {
      setMessage('login', '✅ ' + data.message, 'success')
      clearForm('login')
      
      // Here you could redirect to a dashboard or user area
      console.log('Login successful for:', loginEmail.value)
    } else {
      setMessage('login', '❌ ' + data.detail, 'error')
    }
  } catch (error) {
    console.error('Login error:', error)
    setMessage('login', '❌ Error de conexión. Verifica que el servidor esté ejecutándose.', 'error')
  } finally {
    loginLoading.value = false
  }
}

// Clear messages when switching forms
function switchForm(formType) {
  activeForm.value = formType
  clearMessages()
}
</script>

<style scoped>
* {
  box-sizing: border-box;
}

.app {
  min-height: 100vh;
  background: linear-gradient(135deg, #4c6792 0%, rgb(120, 140, 219) 50%, #4a689b 100%);
  padding: 20px;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
  max-width: 450px;
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  backdrop-filter: blur(10px);
}

.header {
  background: linear-gradient(45deg, #667eea, #764ba2);
  color: white;
  text-align: center;
  padding: 30px 20px;
}

.header h1 {
  margin: 0 0 10px 0;
  font-size: 2.5rem;
  font-weight: 700;
}

.header p {
  margin: 0;
  opacity: 0.9;
  font-size: 1.1rem;
}

.form-toggle {
  display: flex;
  background: #f8f9fa;
  margin: 0;
}

.toggle-btn {
  flex: 1;
  padding: 15px 20px;
  border: none;
  background: transparent;
  cursor: pointer;
  font-size: 1rem;
  font-weight: 600;
  transition: all 0.3s ease;
  color: #666;
}

.toggle-btn.active {
  background: white;
  color: #667eea;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.toggle-btn:hover:not(.active) {
  background: rgba(255, 255, 255, 0.5);
}

.form-container {
  padding: 30px;
}

.form-container h2 {
  margin: 0 0 25px 0;
  color: #333;
  font-size: 1.8rem;
  font-weight: 600;
  text-align: center;
}

.form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.input-group label {
  font-weight: 600;
  color: #333;
  font-size: 0.95rem;
}

.input {
  padding: 15px 18px;
  border: 2px solid #e1e5e9;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: white;
}

.input:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
  transform: translateY(-1px);
}

.input:disabled {
  background: #f8f9fa;
  color: #6c757d;
  cursor: not-allowed;
}

.help-text {
  color: #6c757d;
  font-size: 0.85rem;
  margin-top: 5px;
}

.btn {
  padding: 15px 25px;
  border: none;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin-top: 10px;
}

.btn-primary {
  background: linear-gradient(45deg, #667eea, #764ba2);
  color: white;
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
}

.btn:disabled {
  background: #e9ecef;
  color: #6c757d;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}

.spinner {
  width: 18px;
  height: 18px;
  border: 2px solid transparent;
  border-top: 2px solid currentColor;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.message {
  padding: 15px 20px;
  border-radius: 12px;
  margin-bottom: 20px;
  font-weight: 500;
  text-align: center;
  animation: slideIn 0.3s ease;
}

.message.success {
  background: #d4edda;
  color: #155724;
  border: 1px solid #c3e6cb;
}

.message.error {
  background: #f8d7da;
  color: #721c24;
  border: 1px solid #f5c6cb;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.test-credentials {
  background: #e3f2fd;
  border: 1px solid #bbdefb;
  border-radius: 12px;
  padding: 20px;
  margin-top: 25px;
  text-align: center;
}

.test-credentials p {
  margin: 5px 0;
  color: #1565c0;
}

.test-credentials p:first-child {
  font-weight: 600;
  margin-bottom: 10px;
}

/* Responsive design */
@media (max-width: 480px) {
  .container {
    margin: 10px;
    border-radius: 15px;
  }
  
  .header {
    padding: 20px 15px;
  }
  
  .header h1 {
    font-size: 2rem;
  }
  
  .form-container {
    padding: 20px;
  }
  
  .toggle-btn {
    padding: 12px 15px;
    font-size: 0.9rem;
  }
}
</style>

<!-- Global styles to ensure no white background -->
<style>
html, body {
  margin: 0;
  padding: 0;
  background: linear-gradient(135deg, #2d3748 0%, #4a5568 50%, #2d3748 100%);
  min-height: 100vh;
}

#app {
  min-height: 100vh;
}
</style>