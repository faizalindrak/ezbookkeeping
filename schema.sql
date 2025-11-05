-- Users Table
CREATE TABLE `user` (
    `uid` BIGINT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(32) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `nickname` VARCHAR(64) NOT NULL,
    `password` VARCHAR(64) NOT NULL,
    `salt` VARCHAR(10) NOT NULL,
    `custom_avatar_type` VARCHAR(10),
    `default_account_id` BIGINT,
    `transaction_edit_scope` TINYINT NOT NULL,
    `language` VARCHAR(10),
    `default_currency` VARCHAR(3) NOT NULL,
    `first_day_of_week` TINYINT NOT NULL,
    `fiscal_year_start` SMALLINT,
    `long_date_format` TINYINT,
    `short_date_format` TINYINT,
    `long_time_format` TINYINT,
    `short_time_format` TINYINT,
    `fiscal_year_format` TINYINT,
    `currency_display_type` TINYINT,
    `numeral_system` TINYINT,
    `decimal_separator` TINYINT,
    `digit_grouping_symbol` TINYINT,
    `digit_grouping` TINYINT,
    `coordinate_display_type` TINYINT,
    `expense_amount_color` TINYINT,
    `income_amount_color` TINYINT,
    `feature_restriction` INT,
    `disabled` BOOLEAN,
    `deleted` BOOLEAN NOT NULL,
    `email_verified` BOOLEAN NOT NULL,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    `last_login_unix_time` BIGINT,
    PRIMARY KEY (`uid`),
    UNIQUE (`username`),
    UNIQUE (`email`)
);

-- Accounts Table
CREATE TABLE `account` (
    `account_id` BIGINT NOT NULL AUTO_INCREMENT,
    `uid` BIGINT NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `category` TINYINT NOT NULL,
    `type` TINYINT NOT NULL,
    `parent_account_id` BIGINT NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `display_order` INT NOT NULL,
    `icon` BIGINT NOT NULL,
    `color` VARCHAR(6) NOT NULL,
    `currency` VARCHAR(3) NOT NULL,
    `balance` BIGINT NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `extend` BLOB,
    `hidden` BOOLEAN NOT NULL,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`account_id`),
    INDEX `IDX_account_uid_deleted_parent_account_id_order` (`uid`, `deleted`, `parent_account_id`, `display_order`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- Transactions Table
CREATE TABLE `transaction` (
    `transaction_id` BIGINT NOT NULL AUTO_INCREMENT,
    `uid` BIGINT NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `type` TINYINT NOT NULL,
    `category_id` BIGINT NOT NULL,
    `account_id` BIGINT NOT NULL,
    `transaction_time` BIGINT NOT NULL,
    `timezone_utc_offset` SMALLINT NOT NULL,
    `amount` BIGINT NOT NULL,
    `related_id` BIGINT NOT NULL,
    `related_account_id` BIGINT NOT NULL,
    `related_account_amount` BIGINT NOT NULL,
    `hide_amount` BOOLEAN NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `geo_longitude` DOUBLE,
    `geo_latitude` DOUBLE,
    `created_ip` VARCHAR(39),
    `scheduled_created` BOOLEAN,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`transaction_id`),
    UNIQUE `UQE_transaction_uid_time` (`uid`, `transaction_time`),
    INDEX `IDX_transaction_uid_deleted_time` (`uid`, `deleted`, `transaction_time`),
    INDEX `IDX_transaction_uid_deleted_type_time` (`uid`, `deleted`, `type`, `transaction_time`),
    INDEX `IDX_transaction_uid_deleted_type_account_id_time` (`uid`, `deleted`, `type`, `account_id`, `transaction_time`),
    INDEX `IDX_transaction_uid_deleted_category_id_time` (`uid`, `deleted`, `category_id`, `transaction_time`),
    INDEX `IDX_transaction_uid_deleted_account_id_time` (`uid`, `deleted`, `account_id`, `transaction_time`),
    INDEX `IDX_transaction_uid_deleted_time_longitude_latitude` (`uid`, `deleted`, `transaction_time`, `geo_longitude`, `geo_latitude`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`),
    FOREIGN KEY (`category_id`) REFERENCES `transaction_category`(`category_id`)
);

-- Transaction Categories Table
CREATE TABLE `transaction_category` (
    `category_id` BIGINT NOT NULL AUTO_INCREMENT,
    `uid` BIGINT NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `type` TINYINT NOT NULL,
    `parent_category_id` BIGINT NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `display_order` INT NOT NULL,
    `icon` BIGINT NOT NULL,
    `color` VARCHAR(6) NOT NULL,
    `hidden` BOOLEAN NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`category_id`),
    INDEX `IDX_category_uid_deleted_type_parent_category_id_order` (`uid`, `deleted`, `type`, `parent_category_id`, `display_order`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- Transaction Tags Table
CREATE TABLE `transaction_tag` (
    `tag_id` BIGINT NOT NULL AUTO_INCREMENT,
    `uid` BIGINT NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `display_order` INT NOT NULL,
    `hidden` BOOLEAN NOT NULL,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`tag_id`),
    INDEX `IDX_tag_uid_deleted_order` (`uid`, `deleted`, `display_order`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- Transaction Tag Index Table
CREATE TABLE `transaction_tag_index` (
    `tag_index_id` BIGINT NOT NULL AUTO_INCREMENT,
    `uid` BIGINT,
    `deleted` BOOLEAN NOT NULL,
    `transaction_time` BIGINT NOT NULL,
    `tag_id` BIGINT,
    `transaction_id` BIGINT,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`tag_index_id`),
    INDEX `IDX_transaction_tag_index_uid_deleted_tag_id_transaction_id` (`uid`, `deleted`, `tag_id`, `transaction_id`),
    INDEX `IDX_transaction_tag_index_uid_deleted_transaction_time_tag_id` (`uid`, `deleted`, `transaction_time`, `tag_id`),
    INDEX `IDX_transaction_tag_index_uid_deleted_transaction_id` (`uid`, `deleted`, `transaction_id`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`),
    FOREIGN KEY (`tag_id`) REFERENCES `transaction_tag`(`tag_id`),
    FOREIGN KEY (`transaction_id`) REFERENCES `transaction`(`transaction_id`)
);

-- Transaction Templates Table
CREATE TABLE `transaction_template` (
    `template_id` BIGINT NOT NULL AUTO_INCREMENT,
    `uid` BIGINT NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `template_type` TINYINT NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `type` TINYINT NOT NULL,
    `category_id` BIGINT NOT NULL,
    `account_id` BIGINT NOT NULL,
    `scheduled_frequency_type` TINYINT,
    `scheduled_frequency` VARCHAR(100),
    `scheduled_start_time` BIGINT,
    `scheduled_end_time` BIGINT,
    `scheduled_at` SMALLINT,
    `scheduled_timezone_utc_offset` SMALLINT,
    `tag_ids` VARCHAR(255) NOT NULL,
    `amount` BIGINT NOT NULL,
    `related_account_id` BIGINT NOT NULL,
    `related_account_amount` BIGINT NOT NULL,
    `hide_amount` BOOLEAN NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `display_order` INT NOT NULL,
    `hidden` BOOLEAN NOT NULL,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`template_id`),
    INDEX `IDX_transaction_template_uid_deleted_template_type_order` (`uid`, `deleted`, `template_type`, `display_order`),
    INDEX `IDX_transaction_template_deleted_type_freqtype_scheduled_time` (`deleted`, `template_type`, `scheduled_frequency_type`, `scheduled_start_time`, `scheduled_end_time`, `scheduled_at`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`),
    FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`),
    FOREIGN KEY (`category_id`) REFERENCES `transaction_category`(`category_id`)
);

-- Token Records Table
CREATE TABLE `token_record` (
    `uid` BIGINT NOT NULL,
    `user_token_id` BIGINT NOT NULL,
    `token_type` TINYINT NOT NULL,
    `secret` VARCHAR(10) NOT NULL,
    `user_agent` VARCHAR(255),
    `created_unix_time` BIGINT NOT NULL,
    `expired_unix_time` BIGINT,
    `last_seen_unix_time` BIGINT,
    PRIMARY KEY (`uid`, `user_token_id`, `created_unix_time`),
    INDEX `IDX_token_record_uid_type_expired_time` (`uid`, `token_type`, `expired_unix_time`),
    INDEX `IDX_token_record_expired_time` (`expired_unix_time`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- Two-Factor Table
CREATE TABLE `two_factor` (
    `uid` BIGINT NOT NULL,
    `secret` VARCHAR(80) NOT NULL,
    `created_unix_time` BIGINT,
    PRIMARY KEY (`uid`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- Two-Factor Recovery Codes Table
CREATE TABLE `two_factor_recovery_code` (
    `uid` BIGINT NOT NULL,
    `recovery_code` VARCHAR(64) NOT NULL,
    `used` BOOLEAN NOT NULL,
    `created_unix_time` BIGINT,
    `used_unix_time` BIGINT,
    PRIMARY KEY (`uid`, `recovery_code`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- User Application Cloud Settings Table
CREATE TABLE `user_application_cloud_setting` (
    `uid` BIGINT NOT NULL,
    `settings` BLOB,
    `updated_unix_time` BIGINT,
    PRIMARY KEY (`uid`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- User Custom Exchange Rates Table
CREATE TABLE `user_custom_exchange_rate` (
    `uid` BIGINT NOT NULL,
    `deleted_unix_time` BIGINT NOT NULL,
    `currency` VARCHAR(3) NOT NULL,
    `rate` BIGINT NOT NULL,
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    PRIMARY KEY (`uid`, `deleted_unix_time`, `currency`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`)
);

-- Transaction Picture Info Table
CREATE TABLE `transaction_picture_info` (
    `uid` BIGINT NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `transaction_id` BIGINT NOT NULL,
    `picture_id` BIGINT NOT NULL,
    `picture_extension` VARCHAR(10) NOT NULL,
    `created_ip` VARCHAR(39),
    `created_unix_time` BIGINT,
    `updated_unix_time` BIGINT,
    `deleted_unix_time` BIGINT,
    PRIMARY KEY (`picture_id`),
    INDEX `IDX_transaction_picture_uid_deleted_transaction_id_picture_id` (`uid`, `deleted`, `transaction_id`, `picture_id`),
    INDEX `IDX_transaction_picture_uid_deleted_picture_id` (`uid`, `deleted`, `picture_id`),
    FOREIGN KEY (`uid`) REFERENCES `user`(`uid`),
    FOREIGN KEY (`transaction_id`) REFERENCES `transaction`(`transaction_id`)
);
