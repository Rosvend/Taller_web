# Authentication System

A simple but complete authentication system built with **FastAPI** (backend) and **Vue.js** (frontend).

![Python](https://img.shields.io/badge/Python-3.8+-blue?logo=python) 
![FastAPI](https://img.shields.io/badge/FastAPI-0.116+-teal?logo=fastapi) 
![Vue.js](https://img.shields.io/badge/Vue.js-3-green?logo=vue.js) 
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql) 
![License](https://img.shields.io/badge/license-MIT-lightgrey)
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
```

2. **Start Frontend** (Terminal 2):
```bash
    .\run_frontend.ps1
```

### Access the Application:

Frontend: http://localhost:5173

Backend API: http://localhost:8000

API Docs: http://localhost:8000/docs

### Alternative manual startup
```bash
# Backend
cd backend
uvicorn main:app --reload

# Frontend
cd frontend
npm run dev
```

### Test Credentials
Email: user@test.com

Password: Test123

## 📁 Project Structure
```bash
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
```
## Tech stack
Backend: FastAPI, PostgreSQL, bcrypt, Pydantic

Frontend: Vue.js 3, Vite, HTML5, CSS3

Database: PostgreSQL

Authentication: bcrypt password hashing

## API Endpoints
### POST /registration/

Register a new user account.

Request: FormData with email, password

Response: JSON with success or error message

### POST /login/

Authenticate an existing user.


Request: FormData with email, password

Response: JSON with success or error message
Colaboradora: Susana Toro C. - Universidad Pontificia Bolivariana

## Cambio desde la rama feature-cambio
Este texto fue agregado como parte del taller de Git y GitHub.
Aquí probamos cómo crear un fork, trabajar en una rama y mandar un Pull Request.

## Cambios realizados por Paula Olier
- Edición del archivo README.md
- Prueba de sincronización con el fork