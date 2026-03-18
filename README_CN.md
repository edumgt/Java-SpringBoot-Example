# 🍔 外卖后端服务 — Spring Boot 3.x 多数据库学习实验室

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.8-brightgreen)](https://spring.io/projects/spring-boot)
[![Java](https://img.shields.io/badge/Java-17-blue)](https://adoptium.net/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Sponsor](https://img.shields.io/badge/赞助-%E2%9D%A4-red)](https://github.com/sponsors/edumgt)

> 基于 **Spring Boot 3.x + Java 17** 构建的实战型**学习实验室**项目。  
> 只需切换一个 Profile 即可在 **MSSQL / MySQL / MariaDB / PostgreSQL** 之间自由切换。  
> 内置测试账号，无需注册即可立即体验登录功能。

**📖 其他语言:** [English](README.md) | [한국어](README_KR.md) | [日本語](README_JP.md)

---

## ✨ 主要特性

| 特性 | 说明 |
|---|---|
| **4种数据库 Profile** | MSSQL · MySQL · MariaDB · PostgreSQL |
| **Spring Boot 3.x / Java 17** | Jakarta EE 9+、Security 6、JWT 0.12.x |
| **JWT 认证** | 无状态 REST API 安全认证 |
| **Swagger UI** | 通过 `/swagger-ui/index.html` 查看交互式 API 文档 |
| **Docker Compose** | 一键启动各数据库引擎 |
| **测试账号** | `test1@test.com` / `test2@test.com` — 密码: `123456` |

---

## 🚀 快速开始

### 前置条件
- [Docker](https://docs.docker.com/get-docker/) + Docker Compose
- JDK 17+（或使用 `./mvnw`）

### 1. 选择数据库并启动

| 数据库 | Compose 文件 | 默认端口 |
|---|---|---|
| **MSSQL**（默认） | `docker/docker-compose.yml` | `1433` |
| **MySQL** | `docker/docker-compose-mysql.yml` | `3306` |
| **MariaDB** | `docker/docker-compose-mariadb.yml` | `3307` |
| **PostgreSQL** | `docker/docker-compose-postgresql.yml` | `5432` |

```bash
# 示例：启动 MySQL
cd docker
docker compose -f docker-compose-mysql.yml up -d
```

### 2. 启动应用程序

```bash
# 在项目根目录执行
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

> 将 `mysql` 替换为 `mssql`、`mariadb` 或 `postgresql`。  
> 不指定 Profile 时，默认使用 **`mssql`**。

### 3. 测试登录

```bash
curl -s -X POST http://localhost:8080/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"username":"test1","password":"123456"}' | python3 -m json.tool
```

预期响应（包含 JWT Token）:
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

## 🔑 测试账号

| 邮箱 | 用户名 | 密码 | 角色 |
|---|---|---|---|
| `test1@test.com` | `test1` | `123456` | `ROLE_USER` |
| `test2@test.com` | `test2` | `123456` | `ROLE_USER` |

> 这些账号会在应用首次启动时由 `DataInitializer` 自动创建（适用于所有数据库 Profile）。

---

## 🗄️ 数据库 Profile 详情

### MSSQL（默认）

**配置文件:** `application-mssql.properties`  
**Docker:** `docker/docker-compose.yml`

```bash
cd docker && docker compose up -d
./mvnw spring-boot:run
```

连接信息: `sa / YourStrong!Passw0rd`  · 端口: `1433`

---

### MySQL

**配置文件:** `application-mysql.properties`  
**Docker:** `docker/docker-compose-mysql.yml`

```bash
cd docker && docker compose -f docker-compose-mysql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

连接信息: `fooduser / FoodPass!123`  · 端口: `3306`

---

### MariaDB

**配置文件:** `application-mariadb.properties`  
**Docker:** `docker/docker-compose-mariadb.yml`

```bash
cd docker && docker compose -f docker-compose-mariadb.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mariadb
```

连接信息: `fooduser / FoodPass!123`  · 端口: `3307`

---

### PostgreSQL

**配置文件:** `application-postgresql.properties`  
**Docker:** `docker/docker-compose-postgresql.yml`

```bash
cd docker && docker compose -f docker-compose-postgresql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

连接信息: `fooduser / FoodPass!123`  · 端口: `5432`

---

## 📋 主要 API 端点

| 方法 | 路径 | 认证 | 说明 |
|---|---|---|---|
| `POST` | `/auth/signin` | ❌ | 登录，返回 JWT |
| `POST` | `/auth/signup` | ❌ | 注册新用户 |
| `GET` | `/auth/confirm-account?token=` | ❌ | 邮箱验证 |
| `GET` | `/restaurants` | ✅ | 餐厅列表 |
| `POST` | `/restaurants` | ✅ | 创建餐厅 |
| `GET` | `/meals` | ✅ | 菜单列表 |
| `POST` | `/orders` | ✅ | 创建订单 |

> 完整交互式文档: **http://localhost:8080/swagger-ui/index.html**

---

## 🔧 配置文件结构

所有配置文件位于 `src/main/resources/`。

| 文件 | 用途 |
|---|---|
| `application.properties` | 公共配置 + 激活 Profile |
| `application-mssql.properties` | MSSQL 数据源 |
| `application-mysql.properties` | MySQL 数据源 |
| `application-mariadb.properties` | MariaDB 数据源 |
| `application-postgresql.properties` | PostgreSQL 数据源 |

### 切换激活的 Profile

编辑 `application.properties`:
```properties
spring.profiles.active=postgresql   # mssql | mysql | mariadb | postgresql
```

或通过运行时参数传入:
```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

---

## 🏗️ 技术栈

| 组件 | 版本 |
|---|---|
| Spring Boot | 3.3.8 |
| Java | 17 |
| Spring Security | 6.x |
| jjwt | 0.12.6 |
| springdoc-openapi | 2.6.0 |
| MSSQL JDBC | 12.8.1 |
| MySQL Connector/J | 9.x（托管） |
| MariaDB Connector/J | 3.x（托管） |
| PostgreSQL JDBC | 42.x（托管） |

---

## 🐛 常见问题

### 数据库连接失败
```bash
cd docker
docker compose -f docker-compose-mysql.yml ps
docker compose -f docker-compose-mysql.yml logs
```

### JWT 错误
- 请确认 `application.properties` 中的 `keg.app.jwtSecret` 是一个 Base64 编码的、长度不少于 64 字节的密钥。

### MSSQL Schema 不存在
- MSSQL 使用 `ddl-auto=none`，必须通过 Docker 初始化容器执行 `db.sql` 来创建 Schema。  
  重新初始化: `docker compose down -v && docker compose up -d`

---

## 🤝 参与贡献

欢迎提交 Pull Request！如有重大变更，请先创建 Issue 进行讨论。

---

## 💖 支持本项目

如果这个学习实验室对您的 Spring Boot 学习有所帮助，欢迎成为赞助者，助力项目持续维护与更新！

[![GitHub Sponsors](https://img.shields.io/badge/在GitHub上赞助-%E2%9D%A4-red?logo=github)](https://github.com/sponsors/edumgt)

您的支持将用于:
- 🆕 添加新功能和数据库示例
- 📚 持续更新文档
- 🐛 修复 Bug 和安全补丁
- 🌍 扩展多语言文档

---

## 📄 许可证

[MIT](LICENSE)
