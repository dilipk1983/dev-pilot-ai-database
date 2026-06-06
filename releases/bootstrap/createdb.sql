SELECT 'CREATE DATABASE "DevPilotAI" WITH ENCODING = ''UTF8'' TEMPLATE = template0'
WHERE NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'DevPilotAI')
\gexec

\c "DevPilotAI"

ALTER DATABASE "DevPilotAI" SET default_transaction_isolation = 'read committed';

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'DilipK') THEN
        CREATE ROLE "DilipK" WITH LOGIN PASSWORD 'password' SUPERUSER;
    END IF;
END
$$;