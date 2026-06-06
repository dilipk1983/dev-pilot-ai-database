-- 1. USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,    
    username VARCHAR(30) NOT NULL,
    password_hash TEXT NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT NOW(),
    modified TIMESTAMP NULL
);

-- 2. CARDS TABLE
CREATE TABLE IF NOT EXISTS cards (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    category VARCHAR(50) NULL,
    content TEXT NULL,
    card_type VARCHAR(50) NULL,        
    created TIMESTAMP NOT NULL DEFAULT NOW(),
    modified TIMESTAMP NULL,
    created_by INT NOT NULL,
    CONSTRAINT fk_cards_users_userid FOREIGN KEY (created_by) REFERENCES users(id)  
);

-- 3. DATABASE CREDENTIALS TABLE
CREATE TABLE IF NOT EXISTS database_credentials (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    host VARCHAR(255) NOT NULL,
    port INT DEFAULT 5432, -- Updated default from 1433 (SQL Server) to 5432 (Postgres)
    database VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    password_hash TEXT NULL,
    database_type VARCHAR(50) NOT NULL,
    created_by INT NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT NOW(),
    modified TIMESTAMP NULL,    
    CONSTRAINT fk_db_credentials_users FOREIGN KEY (created_by) REFERENCES users(id)
);

-- 4. CHAT SESSIONS TABLE
CREATE TABLE IF NOT EXISTS chat_sessions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,              
    created TIMESTAMP NOT NULL DEFAULT NOW(),
    modified TIMESTAMP NULL,
    created_by INT NOT NULL,
    CONSTRAINT fk_chatsessions_users_userid FOREIGN KEY (created_by) REFERENCES users(id)  
);

-- 5. CHAT MESSAGES TABLE
CREATE TABLE IF NOT EXISTS chat_messages (
    id SERIAL PRIMARY KEY,
    role VARCHAR(50) NOT NULL,
    content TEXT NULL,             
    created TIMESTAMP NOT NULL DEFAULT NOW(),
    modified TIMESTAMP NULL,
    created_by INT NOT NULL,
    chat_session_id INT NOT NULL,
    CONSTRAINT fk_chatmessages_users_userid FOREIGN KEY (created_by) REFERENCES users(id),
    CONSTRAINT fk_chatmessages_chatsessions_chatsessionid FOREIGN KEY (chat_session_id) REFERENCES chat_sessions(id)
);
