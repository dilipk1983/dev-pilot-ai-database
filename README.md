# Dev Pilot AI Database
This repository uses Liquibase to manage database changes and Docker Compose to run the PostgreSQL database and pgAdmin locally.

## Prerequisites
- Docker Desktop (or Docker Engine + Docker Compose)
- Git
- A local `.env` file with the database and pgAdmin credentials (see below)
- Java 17+ is required inside the container image because Liquibase runs there

## Environment variables
Create a `.env` file in the project root with values like:

```env
DB_PASSWORD=your_strong_password
DB_USER=postgres
DB_NAME=DevPilotAI
PGADMIN_EMAIL=admin@devpilot.ai
PGADMIN_PASSWORD=your_pgadmin_password
```

> Do not commit this file. It is already ignored in `.gitignore`.

## Run the project in Docker
1. Open a terminal in the project root.
2. Build and start the containers:

   ```sh
   docker compose up --build -d --force-recreate
   ```

3. Check that the containers are running:

   ```sh
   docker compose ps
   ```

4. Verify the PostgreSQL database is accepting connections:

   ```sh
   docker exec DevPilotAi-DB psql -U postgres -d DevPilotAI -c '\dt'
   ```

5. Open pgAdmin in your browser:

   ```text
   http://localhost:8080
   ```

   Login with:
   - Email: `PGADMIN_EMAIL` from your `.env`
   - Password: `PGADMIN_PASSWORD` from your `.env`

6. Add the PostgreSQL server in pgAdmin using:
   - Host name/address: `DevPilotAi-DB`
   - Port: `5432`
   - Maintenance database: `DevPilotAI`
   - Username: `postgres`
   - Password: `DB_PASSWORD` from your `.env`

## Stop and clean up
To stop the containers:

```sh
docker compose down
```

To remove containers, networks, and local volumes:

```sh
docker compose down -v --remove-orphans
```

## Notes and tips
- The Docker image uses the PostgreSQL entrypoint plus a custom startup script to create the database and apply Liquibase changes.
- Keep shell scripts with LF line endings; CRLF line endings can break the Docker startup scripts.
- Liquibase metadata is stored in the database and is created automatically during startup.

## Liquibase commands
If you want to run Liquibase manually on your machine, use the project-local tool:

```sh
.\lib\liquibase\liquibase.bat update
```

You can also validate and rollback changes with:

```sh
.\lib\liquibase\liquibase.bat validate
.\lib\liquibase\liquibase.bat rollback <version_tag>
```

For more information, see the Liquibase documentation: https://docs.liquibase.com/
