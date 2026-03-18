-- =============================================
-- MariaDB init script
-- Run once via Docker init container
-- =============================================
CREATE DATABASE IF NOT EXISTS `fooddelivery` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `fooddelivery`;

CREATE TABLE IF NOT EXISTS `email_confirmation_token` (
    `token_id`            BIGINT       NOT NULL AUTO_INCREMENT,
    `confirmation_token`  VARCHAR(255) NULL,
    `created_date`        DATETIME(6)  NULL,
    `user_id`             BIGINT       NOT NULL,
    PRIMARY KEY (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `meals` (
    `meal_id`     BIGINT        NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(250)  NULL,
    `name`        VARCHAR(100)  NULL,
    `price`       DOUBLE        NOT NULL,
    PRIMARY KEY (`meal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `order_meal` (
    `meal_id`  BIGINT NOT NULL,
    `order_id` BIGINT NOT NULL,
    `quantity` INT    NOT NULL,
    PRIMARY KEY (`meal_id`, `order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `order_restaurant` (
    `order_id`      BIGINT NOT NULL,
    `restaurant_id` BIGINT NOT NULL,
    PRIMARY KEY (`order_id`, `restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `order_status` (
    `order_id`  BIGINT      NOT NULL,
    `status_id` BIGINT      NOT NULL,
    `date`      DATETIME(6) NULL,
    PRIMARY KEY (`order_id`, `status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `order_user` (
    `order_id` BIGINT NOT NULL,
    `user_id`  BIGINT NOT NULL,
    PRIMARY KEY (`order_id`, `user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `orders` (
    `order_id`     BIGINT      NOT NULL AUTO_INCREMENT,
    `date`         DATETIME(6) NULL,
    `total_amount` DOUBLE      NULL,
    PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `restaurant_meal` (
    `restaurant_id` BIGINT NOT NULL,
    `meal_id`       BIGINT NOT NULL,
    PRIMARY KEY (`restaurant_id`, `meal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `restaurants` (
    `restaurant_id` BIGINT       NOT NULL AUTO_INCREMENT,
    `description`   VARCHAR(250) NULL,
    `name`          VARCHAR(100) NULL,
    PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `roles` (
    `role_id` BIGINT      NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(20) NULL,
    PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `statuses` (
    `status_id` BIGINT      NOT NULL AUTO_INCREMENT,
    `name`      VARCHAR(20) NULL,
    PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `types` (
    `type_id` BIGINT      NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(20) NULL,
    PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user_restaurant` (
    `user_id`       BIGINT NOT NULL,
    `restaurant_id` BIGINT NOT NULL,
    PRIMARY KEY (`user_id`, `restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user_role` (
    `user_id` BIGINT NOT NULL,
    `role_id` BIGINT NOT NULL,
    PRIMARY KEY (`user_id`, `role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `user_type` (
    `user_id` BIGINT NOT NULL,
    `type_id` BIGINT NOT NULL,
    PRIMARY KEY (`user_id`, `type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `users` (
    `user_id`   BIGINT       NOT NULL AUTO_INCREMENT,
    `blocked`   BOOLEAN      NOT NULL DEFAULT FALSE,
    `email`     VARCHAR(50)  NULL,
    `enabled`   BOOLEAN      NOT NULL DEFAULT FALSE,
    `password`  VARCHAR(120) NULL,
    `photo_url` VARCHAR(500) NULL DEFAULT '',
    `user_name` VARCHAR(20)  NULL,
    PRIMARY KEY (`user_id`),
    UNIQUE KEY `UK_email` (`email`),
    UNIQUE KEY `UK_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Foreign keys (IF NOT EXISTS supported since MariaDB 10.0)
ALTER TABLE `email_confirmation_token`
    ADD CONSTRAINT IF NOT EXISTS `FK_ect_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
ALTER TABLE `order_meal`
    ADD CONSTRAINT IF NOT EXISTS `FK_om_meal`  FOREIGN KEY (`meal_id`)  REFERENCES `meals` (`meal_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_om_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);
ALTER TABLE `order_restaurant`
    ADD CONSTRAINT IF NOT EXISTS `FK_or_rest`  FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_or_order` FOREIGN KEY (`order_id`)      REFERENCES `orders` (`order_id`);
ALTER TABLE `order_status`
    ADD CONSTRAINT IF NOT EXISTS `FK_os_order`  FOREIGN KEY (`order_id`)  REFERENCES `orders` (`order_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_os_status` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`status_id`);
ALTER TABLE `order_user`
    ADD CONSTRAINT IF NOT EXISTS `FK_ou_user`  FOREIGN KEY (`user_id`)  REFERENCES `users` (`user_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_ou_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);
ALTER TABLE `restaurant_meal`
    ADD CONSTRAINT IF NOT EXISTS `FK_rm_meal` FOREIGN KEY (`meal_id`)       REFERENCES `meals` (`meal_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_rm_rest` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`);
ALTER TABLE `user_restaurant`
    ADD CONSTRAINT IF NOT EXISTS `FK_ur_user` FOREIGN KEY (`user_id`)       REFERENCES `users` (`user_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_ur_rest` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`);
ALTER TABLE `user_role`
    ADD CONSTRAINT IF NOT EXISTS `FK_urole_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_urole_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
ALTER TABLE `user_type`
    ADD CONSTRAINT IF NOT EXISTS `FK_utype_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    ADD CONSTRAINT IF NOT EXISTS `FK_utype_type` FOREIGN KEY (`type_id`) REFERENCES `types` (`type_id`);

-- Reference data
INSERT IGNORE INTO `roles` (`role_id`, `name`) VALUES (1,'ROLE_USER'),(2,'ROLE_OWNER'),(3,'ROLE_ADMIN');
INSERT IGNORE INTO `statuses` (`status_id`, `name`) VALUES (1,'PLACED'),(2,'CANCELED'),(3,'PROCESSING'),(4,'IN_ROUTE'),(5,'DELIVERED'),(6,'RECEIVED');
INSERT IGNORE INTO `types` (`type_id`, `name`) VALUES (1,'EMAIL'),(2,'GOOGLE');

-- Test accounts (password: 123456 BCrypt-encoded)
INSERT IGNORE INTO `users` (`blocked`,`email`,`enabled`,`password`,`photo_url`,`user_name`)
VALUES (FALSE,'test1@test.com',TRUE,'$2b$10$M4QD1wOavYczdnpnXGIXT.gU0go9wdrGV1LD4bo5orB1vGWgDY5wa','','test1');
INSERT IGNORE INTO `user_role` (`user_id`,`role_id`)
SELECT u.user_id, r.role_id FROM `users` u, `roles` r WHERE u.email='test1@test.com' AND r.name='ROLE_USER';
INSERT IGNORE INTO `user_type` (`user_id`,`type_id`)
SELECT u.user_id, t.type_id FROM `users` u, `types` t WHERE u.email='test1@test.com' AND t.name='EMAIL';

INSERT IGNORE INTO `users` (`blocked`,`email`,`enabled`,`password`,`photo_url`,`user_name`)
VALUES (FALSE,'test2@test.com',TRUE,'$2b$10$M4QD1wOavYczdnpnXGIXT.gU0go9wdrGV1LD4bo5orB1vGWgDY5wa','','test2');
INSERT IGNORE INTO `user_role` (`user_id`,`role_id`)
SELECT u.user_id, r.role_id FROM `users` u, `roles` r WHERE u.email='test2@test.com' AND r.name='ROLE_USER';
INSERT IGNORE INTO `user_type` (`user_id`,`type_id`)
SELECT u.user_id, t.type_id FROM `users` u, `types` t WHERE u.email='test2@test.com' AND t.name='EMAIL';
