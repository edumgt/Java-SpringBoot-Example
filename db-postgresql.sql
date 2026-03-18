-- =============================================
-- PostgreSQL init script
-- Run automatically by docker-entrypoint-initdb.d
-- (Database 'fooddelivery' is created by POSTGRES_DB env var)
-- =============================================

CREATE TABLE IF NOT EXISTS email_confirmation_token (
    token_id            BIGSERIAL    NOT NULL,
    confirmation_token  VARCHAR(255),
    created_date        TIMESTAMP(6),
    user_id             BIGINT       NOT NULL,
    PRIMARY KEY (token_id)
);

CREATE TABLE IF NOT EXISTS meals (
    meal_id     BIGSERIAL    NOT NULL,
    description VARCHAR(250),
    name        VARCHAR(100),
    price       DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (meal_id)
);

CREATE TABLE IF NOT EXISTS order_meal (
    meal_id  BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (meal_id, order_id)
);

CREATE TABLE IF NOT EXISTS order_restaurant (
    order_id      BIGINT NOT NULL,
    restaurant_id BIGINT NOT NULL,
    PRIMARY KEY (order_id, restaurant_id)
);

CREATE TABLE IF NOT EXISTS order_status (
    order_id  BIGINT       NOT NULL,
    status_id BIGINT       NOT NULL,
    date      TIMESTAMP(6),
    PRIMARY KEY (order_id, status_id)
);

CREATE TABLE IF NOT EXISTS order_user (
    order_id BIGINT NOT NULL,
    user_id  BIGINT NOT NULL,
    PRIMARY KEY (order_id, user_id)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id     BIGSERIAL        NOT NULL,
    date         TIMESTAMP(6),
    total_amount DOUBLE PRECISION,
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS restaurant_meal (
    restaurant_id BIGINT NOT NULL,
    meal_id       BIGINT NOT NULL,
    PRIMARY KEY (restaurant_id, meal_id)
);

CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id BIGSERIAL    NOT NULL,
    description   VARCHAR(250),
    name          VARCHAR(100),
    PRIMARY KEY (restaurant_id)
);

CREATE TABLE IF NOT EXISTS roles (
    role_id BIGSERIAL   NOT NULL,
    name    VARCHAR(20),
    PRIMARY KEY (role_id)
);

CREATE TABLE IF NOT EXISTS statuses (
    status_id BIGSERIAL   NOT NULL,
    name      VARCHAR(20),
    PRIMARY KEY (status_id)
);

CREATE TABLE IF NOT EXISTS types (
    type_id BIGSERIAL   NOT NULL,
    name    VARCHAR(20),
    PRIMARY KEY (type_id)
);

CREATE TABLE IF NOT EXISTS user_restaurant (
    user_id       BIGINT NOT NULL,
    restaurant_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, restaurant_id)
);

CREATE TABLE IF NOT EXISTS user_role (
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE IF NOT EXISTS user_type (
    user_id BIGINT NOT NULL,
    type_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, type_id)
);

CREATE TABLE IF NOT EXISTS users (
    user_id   BIGSERIAL    NOT NULL,
    blocked   BOOLEAN      NOT NULL DEFAULT FALSE,
    email     VARCHAR(50),
    enabled   BOOLEAN      NOT NULL DEFAULT FALSE,
    password  VARCHAR(120),
    photo_url VARCHAR(500) DEFAULT '',
    user_name VARCHAR(20),
    PRIMARY KEY (user_id),
    CONSTRAINT uk_email     UNIQUE (email),
    CONSTRAINT uk_user_name UNIQUE (user_name)
);

-- Foreign keys
ALTER TABLE email_confirmation_token
    ADD CONSTRAINT IF NOT EXISTS fk_ect_user FOREIGN KEY (user_id) REFERENCES users (user_id);
ALTER TABLE order_meal
    ADD CONSTRAINT IF NOT EXISTS fk_om_meal  FOREIGN KEY (meal_id)  REFERENCES meals (meal_id),
    ADD CONSTRAINT IF NOT EXISTS fk_om_order FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE order_restaurant
    ADD CONSTRAINT IF NOT EXISTS fk_or_rest  FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id),
    ADD CONSTRAINT IF NOT EXISTS fk_or_order FOREIGN KEY (order_id)      REFERENCES orders (order_id);
ALTER TABLE order_status
    ADD CONSTRAINT IF NOT EXISTS fk_os_order  FOREIGN KEY (order_id)  REFERENCES orders (order_id),
    ADD CONSTRAINT IF NOT EXISTS fk_os_status FOREIGN KEY (status_id) REFERENCES statuses (status_id);
ALTER TABLE order_user
    ADD CONSTRAINT IF NOT EXISTS fk_ou_user  FOREIGN KEY (user_id)  REFERENCES users (user_id),
    ADD CONSTRAINT IF NOT EXISTS fk_ou_order FOREIGN KEY (order_id) REFERENCES orders (order_id);
ALTER TABLE restaurant_meal
    ADD CONSTRAINT IF NOT EXISTS fk_rm_meal FOREIGN KEY (meal_id)       REFERENCES meals (meal_id),
    ADD CONSTRAINT IF NOT EXISTS fk_rm_rest FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id);
ALTER TABLE user_restaurant
    ADD CONSTRAINT IF NOT EXISTS fk_ur_user FOREIGN KEY (user_id)       REFERENCES users (user_id),
    ADD CONSTRAINT IF NOT EXISTS fk_ur_rest FOREIGN KEY (restaurant_id) REFERENCES restaurants (restaurant_id);
ALTER TABLE user_role
    ADD CONSTRAINT IF NOT EXISTS fk_urole_user FOREIGN KEY (user_id) REFERENCES users (user_id),
    ADD CONSTRAINT IF NOT EXISTS fk_urole_role FOREIGN KEY (role_id) REFERENCES roles (role_id);
ALTER TABLE user_type
    ADD CONSTRAINT IF NOT EXISTS fk_utype_user FOREIGN KEY (user_id) REFERENCES users (user_id),
    ADD CONSTRAINT IF NOT EXISTS fk_utype_type FOREIGN KEY (type_id) REFERENCES types (type_id);

-- Reference data
INSERT INTO roles (role_id, name) VALUES (1,'ROLE_USER'),(2,'ROLE_OWNER'),(3,'ROLE_ADMIN')
    ON CONFLICT DO NOTHING;
INSERT INTO statuses (status_id, name) VALUES (1,'PLACED'),(2,'CANCELED'),(3,'PROCESSING'),(4,'IN_ROUTE'),(5,'DELIVERED'),(6,'RECEIVED')
    ON CONFLICT DO NOTHING;
INSERT INTO types (type_id, name) VALUES (1,'EMAIL'),(2,'GOOGLE')
    ON CONFLICT DO NOTHING;

-- Test accounts (password: 123456 BCrypt-encoded)
INSERT INTO users (blocked, email, enabled, password, photo_url, user_name)
VALUES (FALSE, 'test1@test.com', TRUE, '$2b$10$M4QD1wOavYczdnpnXGIXT.gU0go9wdrGV1LD4bo5orB1vGWgDY5wa', '', 'test1')
    ON CONFLICT DO NOTHING;
INSERT INTO user_role (user_id, role_id)
SELECT u.user_id, r.role_id FROM users u, roles r WHERE u.email='test1@test.com' AND r.name='ROLE_USER'
    ON CONFLICT DO NOTHING;
INSERT INTO user_type (user_id, type_id)
SELECT u.user_id, t.type_id FROM users u, types t WHERE u.email='test1@test.com' AND t.name='EMAIL'
    ON CONFLICT DO NOTHING;

INSERT INTO users (blocked, email, enabled, password, photo_url, user_name)
VALUES (FALSE, 'test2@test.com', TRUE, '$2b$10$M4QD1wOavYczdnpnXGIXT.gU0go9wdrGV1LD4bo5orB1vGWgDY5wa', '', 'test2')
    ON CONFLICT DO NOTHING;
INSERT INTO user_role (user_id, role_id)
SELECT u.user_id, r.role_id FROM users u, roles r WHERE u.email='test2@test.com' AND r.name='ROLE_USER'
    ON CONFLICT DO NOTHING;
INSERT INTO user_type (user_id, type_id)
SELECT u.user_id, t.type_id FROM users u, types t WHERE u.email='test2@test.com' AND t.name='EMAIL'
    ON CONFLICT DO NOTHING;
