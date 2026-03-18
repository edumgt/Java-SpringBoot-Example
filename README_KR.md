# 🍔 음식 배달 백엔드 — Spring Boot 3.x 멀티 DB 학습 Lab

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.8-brightgreen)](https://spring.io/projects/spring-boot)
[![Java](https://img.shields.io/badge/Java-17-blue)](https://adoptium.net/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Sponsor](https://img.shields.io/badge/후원하기-%E2%9D%A4-red)](https://github.com/sponsors/edumgt)

> **Spring Boot 3.x + Java 17** 기반의 실습형 **학습 Lab** 프로젝트입니다.  
> **MSSQL / MySQL / MariaDB / PostgreSQL** 중 하나를 프로파일 하나만 바꿔서 사용할 수 있습니다.  
> 미리 만들어진 테스트 계정으로 회원가입 없이 바로 로그인 테스트가 가능합니다.

**📖 다른 언어:** [English](README.md) | [日本語](README_JP.md) | [中文](README_CN.md)

---

## ✨ 주요 기능

| 기능 | 내용 |
|---|---|
| **4가지 DB 프로파일** | MSSQL · MySQL · MariaDB · PostgreSQL |
| **Spring Boot 3.x / Java 17** | Jakarta EE 9+, Security 6, JWT 0.12.x |
| **JWT 인증** | 상태 비저장 REST API 보안 |
| **Swagger UI** | `/swagger-ui/index.html` 에서 인터랙티브 API 문서 확인 |
| **Docker Compose** | 각 DB 엔진별 원클릭 실행 |
| **테스트 계정** | `test1@test.com` / `test2@test.com` — 비밀번호: `123456` |

---

## 🚀 빠른 시작

### 사전 요구사항
- [Docker](https://docs.docker.com/get-docker/) + Docker Compose
- JDK 17+ (또는 `./mvnw` 사용)

### 1. 데이터베이스 선택 및 실행

| 데이터베이스 | Compose 파일 | 기본 포트 |
|---|---|---|
| **MSSQL** (기본값) | `docker/docker-compose.yml` | `1433` |
| **MySQL** | `docker/docker-compose-mysql.yml` | `3306` |
| **MariaDB** | `docker/docker-compose-mariadb.yml` | `3307` |
| **PostgreSQL** | `docker/docker-compose-postgresql.yml` | `5432` |

```bash
# 예시: MySQL 실행
cd docker
docker compose -f docker-compose-mysql.yml up -d
```

### 2. 애플리케이션 실행

```bash
# 프로젝트 루트에서
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

> `mysql` 자리에 `mssql`, `mariadb`, `postgresql` 중 원하는 것을 입력하세요.  
> 플래그 없이 실행하면 기본값인 **`mssql`** 프로파일이 사용됩니다.

### 3. 로그인 테스트

```bash
curl -s -X POST http://localhost:8080/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"username":"test1","password":"123456"}' | python3 -m json.tool
```

정상 응답 예시 (JWT 토큰 포함):
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

## 🔑 테스트 계정

| 이메일 | 사용자명 | 비밀번호 | 권한 |
|---|---|---|---|
| `test1@test.com` | `test1` | `123456` | `ROLE_USER` |
| `test2@test.com` | `test2` | `123456` | `ROLE_USER` |

> 이 계정들은 애플리케이션 최초 실행 시 `DataInitializer` 에 의해 자동으로 생성됩니다 (모든 DB 프로파일 공통).

---

## 🗄️ 데이터베이스 프로파일 상세

### MSSQL (기본값)

**설정:** `application-mssql.properties`  
**Docker:** `docker/docker-compose.yml`

```bash
cd docker && docker compose up -d
./mvnw spring-boot:run
```

접속 정보: `sa / YourStrong!Passw0rd`  · 포트: `1433`

---

### MySQL

**설정:** `application-mysql.properties`  
**Docker:** `docker/docker-compose-mysql.yml`

```bash
cd docker && docker compose -f docker-compose-mysql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

접속 정보: `fooduser / FoodPass!123`  · 포트: `3306`

---

### MariaDB

**설정:** `application-mariadb.properties`  
**Docker:** `docker/docker-compose-mariadb.yml`

```bash
cd docker && docker compose -f docker-compose-mariadb.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mariadb
```

접속 정보: `fooduser / FoodPass!123`  · 포트: `3307`

---

### PostgreSQL

**설정:** `application-postgresql.properties`  
**Docker:** `docker/docker-compose-postgresql.yml`

```bash
cd docker && docker compose -f docker-compose-postgresql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

접속 정보: `fooduser / FoodPass!123`  · 포트: `5432`

---

## 📋 주요 API 엔드포인트

| 메서드 | 경로 | 인증 | 설명 |
|---|---|---|---|
| `POST` | `/auth/signin` | ❌ | 로그인, JWT 반환 |
| `POST` | `/auth/signup` | ❌ | 신규 회원가입 |
| `GET` | `/auth/confirm-account?token=` | ❌ | 이메일 인증 |
| `GET` | `/restaurants` | ✅ | 레스토랑 목록 |
| `POST` | `/restaurants` | ✅ | 레스토랑 등록 |
| `GET` | `/meals` | ✅ | 메뉴 목록 |
| `POST` | `/orders` | ✅ | 주문 생성 |

> 전체 인터랙티브 문서: **http://localhost:8080/swagger-ui/index.html**

---

## 🔧 설정 파일 구조

모든 설정 파일은 `src/main/resources/` 에 있습니다.

| 파일 | 용도 |
|---|---|
| `application.properties` | 공통 설정 + 활성 프로파일 지정 |
| `application-mssql.properties` | MSSQL 데이터소스 |
| `application-mysql.properties` | MySQL 데이터소스 |
| `application-mariadb.properties` | MariaDB 데이터소스 |
| `application-postgresql.properties` | PostgreSQL 데이터소스 |

### 활성 프로파일 변경

`application.properties` 수정:
```properties
spring.profiles.active=postgresql   # mssql | mysql | mariadb | postgresql
```

또는 런타임 인자로 전달:
```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

---

## 🏗️ 기술 스택

| 구성 요소 | 버전 |
|---|---|
| Spring Boot | 3.3.8 |
| Java | 17 |
| Spring Security | 6.x |
| jjwt | 0.12.6 |
| springdoc-openapi | 2.6.0 |
| MSSQL JDBC | 12.8.1 |
| MySQL Connector/J | 9.x (관리됨) |
| MariaDB Connector/J | 3.x (관리됨) |
| PostgreSQL JDBC | 42.x (관리됨) |

---

## 🐛 트러블슈팅

### DB 연결 실패
```bash
cd docker
docker compose -f docker-compose-mysql.yml ps
docker compose -f docker-compose-mysql.yml logs
```

### JWT 오류
- `application.properties` 의 `keg.app.jwtSecret` 값이 Base64 인코딩된 64바이트 이상의 키인지 확인하세요.

### MSSQL 스키마 없음
- MSSQL은 `ddl-auto=none` 설정이므로 `db.sql` 을 통해 스키마를 미리 생성해야 합니다.  
  재실행: `docker compose down -v && docker compose up -d`

---

## 🤝 기여하기

Pull Request 를 환영합니다! 큰 변경사항은 먼저 Issue 를 열어 논의해 주세요.

---

## 💖 이 프로젝트 후원하기

이 Lab 이 Spring Boot 학습에 도움이 되었다면, 후원을 통해 프로젝트 유지 및 발전에 힘을 보태주세요!

[![GitHub Sponsors](https://img.shields.io/badge/GitHub에서%20후원하기-%E2%9D%A4-red?logo=github)](https://github.com/sponsors/edumgt)

후원금은 아래에 사용됩니다:
- 🆕 새로운 기능 및 DB 예제 추가
- 📚 문서 최신화 유지
- 🐛 버그 수정 및 보안 패치
- 🌍 다국어 문서 확대

---

## 📄 라이선스

[MIT](LICENSE)
