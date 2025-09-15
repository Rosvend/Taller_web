# Taller Web - Authentication System

A simple but complete authentication system built with **FastAPI** (backend) and **Vue.js** (frontend).

---

## 🚀 Quick Start

### Prerequisites
- **Python 3.8+** installed  
- **Node.js 16+** installed  
- **PostgreSQL** running locally or remotely  

---

### Running the Application

1. **Start Backend** (Terminal 1):
   ```bash
   .\run_backend.bat
Start Frontend (Terminal 2):

bash
Copy code
.\run_frontend.ps1
Access the Application:

Frontend: http://localhost:5173

Backend API: http://localhost:8000

API Docs: http://localhost:8000/docs

Alternative manual startup
bash
Copy code
# Backend
cd backend
uvicorn main:app --reload

# Frontend
cd frontend
npm run dev
🔑 Test Credentials
Email: user@test.com

Password: Test123

📁 Project Structure
bash
Copy code
Taller_web/
├── backend/
│   ├── main.py           # FastAPI application
│   ├── models.py         # Pydantic models
│   ├── middleware.py     # CORS configuration
│   ├── encryption.py     # Password hashing utilities
│   └── database.sql      # Database schema
├── frontend/
│   ├── src/
│   │   ├── App.vue       # Main Vue component
│   │   └── style.css     # Global styles
│   ├── package.json      # Node.js dependencies
│   └── vite.config.js    # Vite configuration
├── requirements.txt      # Python dependencies
├── run_backend.bat       # Backend startup script (Windows)
└── run_frontend.ps1      # Frontend startup script (Windows)
🛠️ Technical Stack
Backend: FastAPI, PostgreSQL, bcrypt, Pydantic

Frontend: Vue.js 3, Vite, HTML5, CSS3

Database: PostgreSQL

Authentication: bcrypt password hashing

📡 API Endpoints
POST /registration/
Register a new user account.

Request: FormData with email, password
Response: JSON with success or error message

POST /login/
Authenticate an existing user.

Request: FormData with email, password
Response: JSON with success or error message