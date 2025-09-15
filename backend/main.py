from fastapi import FastAPI, Form, HTTPException
import psycopg2
from typing import Annotated
from models import User
from middleware import add_cors
from encryption import hash_password, check_password

app = FastAPI()
add_cors(app)

def get_connection():
    return psycopg2.connect(
        dbname="taller_web",
        user="taller_web_user",
        password="UnaClav3",
        host="localhost",
        port="5432"
    )

@app.post("/login/")
async def login(data: Annotated[User, Form()]):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT password FROM users WHERE email = %s", (data.email,))
    row = cursor.fetchone()
    if not row or not check_password(data.password, row[0]):
        cursor.close()
        conn.close()
        raise HTTPException(status_code=400, detail="Invalid credentials")
    return {"message": "Login successful"}

@app.post("/registration/")
async def registration(data: Annotated[User, Form()]):
    conn = get_connection()
    cursor = conn.cursor()
    hashed_password = hash_password(data.password)

    cursor.execute("SELECT 1 FROM users WHERE email = %s", (data.email,))
    if cursor.fetchone():
        cursor.close()
        conn.close()
        raise HTTPException(status_code=400, detail="Email already registered")

    cursor.execute("INSERT INTO users (email, password) VALUES (%s, %s)", (data.email, hashed_password))
    conn.commit()
    cursor.close()
    conn.close()
    return {"message": "Registration successful"}