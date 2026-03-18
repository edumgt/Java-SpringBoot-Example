# 🍔 Food Delivery Backend — Spring Boot 3.x Multi-DB Lab

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.8-brightgreen)](https://spring.io/projects/spring-boot)
[![Java](https://img.shields.io/badge/Java-17-blue)](https://adoptium.net/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Sponsor](https://img.shields.io/badge/Sponsor-%E2%9D%A4-red)](https://github.com/sponsors/edumgt)

> A hands-on **learning lab** built with **Spring Boot 3.x + Java 17**.  
> Switch between **MSSQL / MySQL / MariaDB / PostgreSQL** with a single profile flag.  
> Pre-loaded test accounts let you log in immediately — no registration required.

**📖 Other Languages:** [한국어](README_KR.md) | [日本語](README_JP.md) | [中文](README_CN.md)

---

## ✨ Key Features

| Feature | Detail |
|---|---|
| **4 Database Profiles** | MSSQL · MySQL · MariaDB · PostgreSQL |
| **Spring Boot 3.x / Java 17** | Jakarta EE 9+, Security 6, JWT 0.12.x |
| **JWT Authentication** | Stateless REST API security |
| **Swagger UI** | Interactive API docs at `/swagger-ui/index.html` |
| **Docker Compose** | One-command DB startup for each engine |
| **Test Accounts** | `test1@test.com` / `test2@test.com` — password: `123456` |

---

## 🚀 Quick Start

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) + Docker Compose
- JDK 17+ (or use `./mvnw`)

### 1. Choose a Database and Start It

| Database | Compose file | Default port |
|---|---|---|
| **MSSQL** (default) | `docker/docker-compose.yml` | `1433` |
| **MySQL** | `docker/docker-compose-mysql.yml` | `3306` |
| **MariaDB** | `docker/docker-compose-mariadb.yml` | `3307` |
| **PostgreSQL** | `docker/docker-compose-postgresql.yml` | `5432` |

```bash
# Example: start MySQL
cd docker
docker compose -f docker-compose-mysql.yml up -d
```

### 2. Run the Application

```bash
# From the project root
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

> Replace `mysql` with `mssql`, `mariadb`, or `postgresql` as needed.  
> The default profile (no flag) is **`mssql`**.

### 3. Test Login

```bash
curl -s -X POST http://localhost:8080/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"username":"test1","password":"123456"}' | python3 -m json.tool
```

Expected response — contains a JWT token:
```json
{
  "token": "eyJ...",
  "id": 1,
  "username": "test1",
  "email": "test1@test.com",
  "roles": ["ROLE_USER"]
}
```

---

## 🔑 Test Accounts

| Email | Username | Password | Role |
|---|---|---|---|
| `test1@test.com` | `test1` | `123456` | `ROLE_USER` |
| `test2@test.com` | `test2` | `123456` | `ROLE_USER` |

> These accounts are automatically created by `DataInitializer` on first startup, for every database profile.

---

## 🗄️ Database Profiles

### MSSQL (default)

**Properties:** `application-mssql.properties`  
**Docker:** `docker/docker-compose.yml`

```bash
cd docker && docker compose up -d
./mvnw spring-boot:run
```

Credentials: `sa / YourStrong!Passw0rd`  · Port: `1433`

---

### MySQL

**Properties:** `application-mysql.properties`  
**Docker:** `docker/docker-compose-mysql.yml`

```bash
cd docker && docker compose -f docker-compose-mysql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

Credentials: `fooduser / FoodPass!123`  · Port: `3306`

---

### MariaDB

**Properties:** `application-mariadb.properties`  
**Docker:** `docker/docker-compose-mariadb.yml`

```bash
cd docker && docker compose -f docker-compose-mariadb.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mariadb
```

Credentials: `fooduser / FoodPass!123`  · Port: `3307`

---

### PostgreSQL

**Properties:** `application-postgresql.properties`  
**Docker:** `docker/docker-compose-postgresql.yml`

```bash
cd docker && docker compose -f docker-compose-postgresql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

Credentials: `fooduser / FoodPass!123`  · Port: `5432`

---

## 📋 API Endpoints

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| `POST` | `/auth/signin` | ❌ | Login, returns JWT |
| `POST` | `/auth/signup` | ❌ | Register new user |
| `GET` | `/auth/confirm-account?token=` | ❌ | Confirm email |
| `GET` | `/restaurants` | ✅ | List restaurants |
| `POST` | `/restaurants` | ✅ | Create restaurant |
| `GET` | `/meals` | ✅ | List meals |
| `POST` | `/orders` | ✅ | Place order |

> Full interactive docs: **http://localhost:8080/swagger-ui/index.html**

---

## 🔧 Configuration

All settings live in `src/main/resources/`.

| File | Purpose |
|---|---|
| `application.properties` | Common settings + active profile |
| `application-mssql.properties` | MSSQL datasource |
| `application-mysql.properties` | MySQL datasource |
| `application-mariadb.properties` | MariaDB datasource |
| `application-postgresql.properties` | PostgreSQL datasource |

### Change Active Profile

Edit `application.properties`:
```properties
spring.profiles.active=postgresql   # mssql | mysql | mariadb | postgresql
```

Or pass as a runtime argument:
```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

---

## 🏗️ Tech Stack

| Component | Version |
|---|---|
| Spring Boot | 3.3.8 |
| Java | 17 |
| Spring Security | 6.x |
| jjwt | 0.12.6 |
| springdoc-openapi | 2.6.0 |
| MSSQL JDBC | 12.8.1 |
| MySQL Connector/J | 9.x (managed) |
| MariaDB Connector/J | 3.x (managed) |
| PostgreSQL JDBC | 42.x (managed) |

---

## 🐛 Troubleshooting

### DB Connection Fails
```bash
cd docker
docker compose -f docker-compose-mysql.yml ps
docker compose -f docker-compose-mysql.yml logs
```

### JWT Errors
- Ensure `keg.app.jwtSecret` in `application.properties` is a Base64-encoded key ≥ 64 bytes.

### Schema Not Created (MSSQL)
- `ddl-auto=none` for MSSQL — tables must be created by `db.sql` via the Docker init container.  
  Re-run: `docker compose down -v && docker compose up -d`

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first.

---

## 💖 Support This Project

If this lab helped you learn Spring Boot, please consider sponsoring to keep it maintained and updated!

[![GitHub Sponsors](https://img.shields.io/badge/Sponsor%20on%20GitHub-%E2%9D%A4-red?logo=github)](https://github.com/sponsors/edumgt)

Your support helps:
- 🆕 Add new features and database examples
- 📚 Keep documentation up-to-date
- 🐛 Fix bugs and security patches
- 🌍 Expand multi-language documentation

---

## 📄 License

[MIT](LICENSE)

