# Food Delivery Backend (Spring Boot 3.x)

이 프로젝트는 **Spring Boot 3.x + Java 17** 기반으로 업그레이드된 음식 배달 백엔드입니다.  
DB는 **Docker(Microsoft SQL Server)** 로 실행하고, 스키마/초기 데이터는 `db.sql`로 구성합니다.

## 1) 이번 업그레이드 핵심

- Spring Boot `2.4.2` → **`3.3.8`**
- Java `15` → **`17`**
- `javax.*` API → **`jakarta.*`** 전환 (JPA/Validation/Servlet/Transaction)
- Spring Security 구성을 `WebSecurityConfigurerAdapter` 기반에서 **SecurityFilterChain 기반**으로 전환
- JWT 라이브러리 `jjwt 0.9.1` → **`jjwt 0.12.6`** 로 전환
- OpenAPI 라이브러리 `springdoc-openapi-ui 1.x` → **`springdoc-openapi-starter-webmvc-ui 2.x`** 로 전환

## 2) 왜 이렇게 바뀌는가? (기술 설명)

### Spring Boot 3.x + Jakarta EE 9+
Spring Framework 6 / Boot 3부터는 Jakarta EE 패키지를 사용하므로, 과거 `javax.persistence.*`, `javax.validation.*`, `javax.servlet.*` 는 동작하지 않습니다.  
따라서 엔티티/컨트롤러/필터 전반 import를 `jakarta.*`로 바꿔야 합니다.

### Security 구성 방식 변화
`WebSecurityConfigurerAdapter` 는 최신 Spring Security에서 제거되었습니다.  
대신 아래처럼 Bean 기반으로 나누어 구성합니다.

- `SecurityFilterChain` : URL 인가 정책, 세션 정책, 필터 체인 구성
- `DaoAuthenticationProvider` : `UserDetailsService + PasswordEncoder` 조합
- `AuthenticationManager` : `AuthenticationConfiguration` 에서 주입

### JWT 0.12.x 변화
기존 `signWith(SignatureAlgorithm, String)` / `parser().setSigningKey(...)` 방식 대신:

- `signWith(SecretKey, SignatureAlgorithm)`
- `Jwts.parser().verifyWith(SecretKey).build()`

를 사용합니다. 또한 HS512 사용 시 충분한 길이의 키(권장 64바이트 이상)가 필요합니다.

## 3) 사전 요구사항

- Docker / Docker Compose
- JDK 17+
- Maven Wrapper 사용 가능 환경 (`./mvnw`)

## 4) DB 실행 (Docker)

프로젝트 루트 기준:

```bash
cd docker
docker compose up -d
```

구성:

- `sqlserver` : SQL Server 2022 컨테이너
- `sqlserver-init` : `db.sql`을 실행해 테이블/초기 데이터 세팅

`db.sql`에는 DB 생성 체크 + 테이블/관계/기초 데이터(roles, statuses, types 등)가 포함되어 있습니다.

> 기본 계정: `sa / YourStrong!Passw0rd`  
> 포트: `1433`

## 5) 애플리케이션 실행

루트 디렉터리에서:

```bash
./mvnw spring-boot:run
```

기본 접속:

- API: `http://localhost:8080`
- Swagger UI: `http://localhost:8080/swagger-ui/index.html`
- OpenAPI JSON: `http://localhost:8080/v3/api-docs`

## 6) 주요 설정 파일

- 애플리케이션 설정: `src/main/resources/application.properties`
  - DB 접속 정보
  - JWT secret / 만료시간
  - 메일 설정
- DB 초기화 SQL: `db.sql`
- Docker Compose: `docker/docker-compose.yml`

## 7) 트러블슈팅

### DB 연결 실패
- Docker 컨테이너 상태 확인:
  ```bash
  cd docker
  docker compose ps
  docker compose logs sqlserver
  docker compose logs sqlserver-init
  ```

### JWT 관련 오류
- `keg.app.jwtSecret` 값이 너무 짧거나 형식이 잘못되면 서명/검증 실패가 발생합니다.
- 현재 설정은 Base64 인코딩된 긴 키를 사용하도록 맞춰져 있습니다.

### 스키마 자동생성 비활성화
- `spring.jpa.hibernate.ddl-auto=none` 으로 설정되어 있으므로, DB 스키마는 반드시 `db.sql`로 준비되어야 합니다.

---

필요하면 다음 단계로, `application-dev.properties / application-prod.properties` 프로파일 분리와 시크릿 환경변수화까지 이어서 정리할 수 있습니다.
