# 🍔 フードデリバリーバックエンド — Spring Boot 3.x マルチDB学習ラボ

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.8-brightgreen)](https://spring.io/projects/spring-boot)
[![Java](https://img.shields.io/badge/Java-17-blue)](https://adoptium.net/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Sponsor](https://img.shields.io/badge/スポンサー-%E2%9D%A4-red)](https://github.com/sponsors/edumgt)

> **Spring Boot 3.x + Java 17** をベースにした実践的な**学習ラボ**プロジェクトです。  
> プロファイルを1つ変えるだけで **MSSQL / MySQL / MariaDB / PostgreSQL** を切り替えられます。  
> あらかじめ用意されたテストアカウントで、会員登録なしにすぐログインテストが可能です。

**📖 他の言語:** [English](README.md) | [한국어](README_KR.md) | [中文](README_CN.md)

---

## ✨ 主な機能

| 機能 | 内容 |
|---|---|
| **4種類のDBプロファイル** | MSSQL · MySQL · MariaDB · PostgreSQL |
| **Spring Boot 3.x / Java 17** | Jakarta EE 9+, Security 6, JWT 0.12.x |
| **JWT認証** | ステートレスREST APIセキュリティ |
| **Swagger UI** | `/swagger-ui/index.html` でインタラクティブなAPI仕様確認 |
| **Docker Compose** | 各DBエンジンをワンコマンドで起動 |
| **テストアカウント** | `test1@test.com` / `test2@test.com` — パスワード: `123456` |

---

## 🚀 クイックスタート

### 前提条件
- [Docker](https://docs.docker.com/get-docker/) + Docker Compose
- JDK 17+（または `./mvnw` を使用）

### 1. データベースを選んで起動

| データベース | Composeファイル | デフォルトポート |
|---|---|---|
| **MSSQL**（デフォルト） | `docker/docker-compose.yml` | `1433` |
| **MySQL** | `docker/docker-compose-mysql.yml` | `3306` |
| **MariaDB** | `docker/docker-compose-mariadb.yml` | `3307` |
| **PostgreSQL** | `docker/docker-compose-postgresql.yml` | `5432` |

```bash
# 例: MySQLを起動
cd docker
docker compose -f docker-compose-mysql.yml up -d
```

### 2. アプリケーションを起動

```bash
# プロジェクトルートから
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

> `mysql` の部分を `mssql`、`mariadb`、`postgresql` に変えてください。  
> フラグなしで実行した場合は、デフォルトの **`mssql`** プロファイルが使用されます。

### 3. ログインテスト

```bash
curl -s -X POST http://localhost:8080/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"username":"test1","password":"123456"}' | python3 -m json.tool
```

期待されるレスポンス（JWTトークン含む）:
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

## 🔑 テストアカウント

| メール | ユーザー名 | パスワード | 権限 |
|---|---|---|---|
| `test1@test.com` | `test1` | `123456` | `ROLE_USER` |
| `test2@test.com` | `test2` | `123456` | `ROLE_USER` |

> これらのアカウントは、アプリ初回起動時に `DataInitializer` によって自動的に作成されます（全DBプロファイル共通）。

---

## 🗄️ データベースプロファイル詳細

### MSSQL（デフォルト）

**設定:** `application-mssql.properties`  
**Docker:** `docker/docker-compose.yml`

```bash
cd docker && docker compose up -d
./mvnw spring-boot:run
```

接続情報: `sa / YourStrong!Passw0rd`  · ポート: `1433`

---

### MySQL

**設定:** `application-mysql.properties`  
**Docker:** `docker/docker-compose-mysql.yml`

```bash
cd docker && docker compose -f docker-compose-mysql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
```

接続情報: `fooduser / FoodPass!123`  · ポート: `3306`

---

### MariaDB

**設定:** `application-mariadb.properties`  
**Docker:** `docker/docker-compose-mariadb.yml`

```bash
cd docker && docker compose -f docker-compose-mariadb.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=mariadb
```

接続情報: `fooduser / FoodPass!123`  · ポート: `3307`

---

### PostgreSQL

**設定:** `application-postgresql.properties`  
**Docker:** `docker/docker-compose-postgresql.yml`

```bash
cd docker && docker compose -f docker-compose-postgresql.yml up -d
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

接続情報: `fooduser / FoodPass!123`  · ポート: `5432`

---

## 📋 主なAPIエンドポイント

| メソッド | パス | 認証 | 説明 |
|---|---|---|---|
| `POST` | `/auth/signin` | ❌ | ログイン・JWT返却 |
| `POST` | `/auth/signup` | ❌ | 新規ユーザー登録 |
| `GET` | `/auth/confirm-account?token=` | ❌ | メール認証 |
| `GET` | `/restaurants` | ✅ | レストラン一覧 |
| `POST` | `/restaurants` | ✅ | レストラン作成 |
| `GET` | `/meals` | ✅ | メニュー一覧 |
| `POST` | `/orders` | ✅ | 注文作成 |

> フルドキュメント: **http://localhost:8080/swagger-ui/index.html**

---

## 🔧 設定ファイル構成

全設定ファイルは `src/main/resources/` に配置されています。

| ファイル | 用途 |
|---|---|
| `application.properties` | 共通設定 + アクティブプロファイル指定 |
| `application-mssql.properties` | MSSQLデータソース |
| `application-mysql.properties` | MySQLデータソース |
| `application-mariadb.properties` | MariaDBデータソース |
| `application-postgresql.properties` | PostgreSQLデータソース |

### アクティブプロファイルの変更

`application.properties` を編集:
```properties
spring.profiles.active=postgresql   # mssql | mysql | mariadb | postgresql
```

または実行時に引数として渡す:
```bash
./mvnw spring-boot:run -Dspring-boot.run.profiles=postgresql
```

---

## 🏗️ 技術スタック

| コンポーネント | バージョン |
|---|---|
| Spring Boot | 3.3.8 |
| Java | 17 |
| Spring Security | 6.x |
| jjwt | 0.12.6 |
| springdoc-openapi | 2.6.0 |
| MSSQL JDBC | 12.8.1 |
| MySQL Connector/J | 9.x（管理済み） |
| MariaDB Connector/J | 3.x（管理済み） |
| PostgreSQL JDBC | 42.x（管理済み） |

---

## 🐛 トラブルシューティング

### DB接続失敗
```bash
cd docker
docker compose -f docker-compose-mysql.yml ps
docker compose -f docker-compose-mysql.yml logs
```

### JWTエラー
- `application.properties` の `keg.app.jwtSecret` がBase64エンコードされた64バイト以上のキーであることを確認してください。

### MSSQLスキーマが存在しない
- MSSQLは `ddl-auto=none` のため、`db.sql` でスキーマを事前に作成する必要があります。  
  再実行: `docker compose down -v && docker compose up -d`

---

## 🤝 コントリビューション

プルリクエストを歓迎します！大きな変更の場合は、まずIssueを開いてご相談ください。

---

## 💖 このプロジェクトをサポートする

このラボがSpring Bootの学習に役立てたなら、ぜひスポンサーとして支援をお願いします！

[![GitHub Sponsors](https://img.shields.io/badge/GitHubでスポンサーになる-%E2%9D%A4-red?logo=github)](https://github.com/sponsors/edumgt)

支援金の用途:
- 🆕 新機能・DBサンプルの追加
- 📚 ドキュメントの継続的な更新
- 🐛 バグ修正・セキュリティパッチ
- 🌍 多言語ドキュメントの拡充

---

## 📄 ライセンス

[MIT](LICENSE)
