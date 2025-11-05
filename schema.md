# Database Schema

This document provides a comprehensive overview of the database schema, including tables, columns, and their relationships.

## Tables

- [user](#user)
- [account](#account)
- [transaction](#transaction)
- [transaction_category](#transaction_category)
- [transaction_tag](#transaction_tag)
- [transaction_tag_index](#transaction_tag_index)
- [transaction_template](#transaction_template)
- [token_record](#token_record)
- [two_factor](#two_factor)
- [two_factor_recovery_code](#two_factor_recovery_code)
- [user_application_cloud_setting](#user_application_cloud_setting)
- [user_custom_exchange_rate](#user_custom_exchange_rate)
- [transaction_picture_info](#transaction_picture_info)

---

### `user`

The `user` table stores information about the application's users.

| Column                  | Type         | Description                                                                 |
| ----------------------- | ------------ | --------------------------------------------------------------------------- |
| `uid`                   | BIGINT       | **Primary Key** - A unique identifier for each user.                        |
| `username`              | VARCHAR(32)  | The user's username (must be unique).                                       |
| `email`                 | VARCHAR(100) | The user's email address (must be unique).                                  |
| `nickname`              | VARCHAR(64)  | The user's display name.                                                    |
| `password`              | VARCHAR(64)  | The user's hashed password.                                                 |
| `salt`                  | VARCHAR(10)  | A random salt used for password hashing.                                    |
| `custom_avatar_type`    | VARCHAR(10)  | The type of custom avatar the user has.                                     |
| `default_account_id`    | BIGINT       | The ID of the user's default account (foreign key to `account.account_id`). |
| `transaction_edit_scope`| TINYINT      | The scope within which transactions can be edited.                          |
| `language`              | VARCHAR(10)  | The user's preferred language.                                              |
| `default_currency`      | VARCHAR(3)   | The user's default currency.                                                |
| `first_day_of_week`     | TINYINT      | The first day of the week for the user.                                     |
| `fiscal_year_start`     | SMALLINT     | The start of the fiscal year for the user.                                  |
| `long_date_format`      | TINYINT      | The user's preferred long date format.                                      |
| `short_date_format`     | TINYINT      | The user's preferred short date format.                                     |
| `long_time_format`      | TINYINT      | The user's preferred long time format.                                      |
| `short_time_format`     | TINYINT      | The user's preferred short time format.                                     |
| `fiscal_year_format`    | TINYINT      | The user's preferred fiscal year format.                                    |
| `currency_display_type` | TINYINT      | How currency is displayed to the user.                                      |
| `numeral_system`        | TINYINT      | The numeral system used by the user.                                        |
| `decimal_separator`     | TINYINT      | The decimal separator used by the user.                                     |
| `digit_grouping_symbol` | TINYINT      | The digit grouping symbol used by the user.                                 |
| `digit_grouping`        | TINYINT      | The type of digit grouping used by the user.                                |
| `coordinate_display_type` | TINYINT    | How coordinates are displayed to the user.                                  |
| `expense_amount_color`  | TINYINT      | The color used for expense amounts.                                         |
| `income_amount_color`   | TINYINT      | The color used for income amounts.                                          |
| `feature_restriction`   | INT          | Any feature restrictions applied to the user.                               |
| `disabled`              | BOOLEAN      | Whether the user's account is disabled.                                     |
| `deleted`               | BOOLEAN      | Whether the user's account is deleted.                                      |
| `email_verified`        | BOOLEAN      | Whether the user's email address has been verified.                         |
| `created_unix_time`     | BIGINT       | The timestamp when the user account was created.                            |
| `updated_unix_time`     | BIGINT       | The timestamp when the user account was last updated.                       |
| `deleted_unix_time`     | BIGINT       | The timestamp when the user account was deleted.                            |
| `last_login_unix_time`  | BIGINT       | The timestamp of the user's last login.                                     |

---

### `account`

The `account` table stores information about user accounts.

| Column            | Type        | Description                                                              |
| ----------------- | ----------- | ------------------------------------------------------------------------ |
| `account_id`      | BIGINT      | **Primary Key** - A unique identifier for each account.                  |
| `uid`             | BIGINT      | **Foreign Key** to `user.uid`.                                           |
| `deleted`         | BOOLEAN     | Whether the account is deleted.                                          |
| `category`        | TINYINT     | The category of the account.                                             |
| `type`            | TINYINT     | The type of the account.                                                 |
| `parent_account_id` | BIGINT    | The ID of the parent account, if any.                                    |
| `name`            | VARCHAR(64) | The name of the account.                                                 |
| `display_order`   | INT         | The order in which the account is displayed.                             |
| `icon`            | BIGINT      | The icon associated with the account.                                    |
| `color`           | VARCHAR(6)  | The color associated with the account.                                   |
| `currency`        | VARCHAR(3)  | The currency of the account.                                             |
| `balance`         | BIGINT      | The current balance of the account.                                      |
| `comment`         | VARCHAR(255)| Any comments about the account.                                          |
| `extend`          | BLOB        | Extended data for the account.                                           |
| `hidden`          | BOOLEAN     | Whether the account is hidden.                                           |
| `created_unix_time`| BIGINT    | The timestamp when the account was created.                              |
| `updated_unix_time`| BIGINT    | The timestamp when the account was last updated.                         |
| `deleted_unix_time`| BIGINT    | The timestamp when the account was deleted.                              |

---

### `transaction`

The `transaction` table stores all financial transactions.

| Column                   | Type         | Description                                                                 |
| ------------------------ | ------------ | --------------------------------------------------------------------------- |
| `transaction_id`         | BIGINT       | **Primary Key** - A unique identifier for each transaction.                 |
| `uid`                    | BIGINT       | **Foreign Key** to `user.uid`.                                              |
| `deleted`                | BOOLEAN      | Whether the transaction is deleted.                                         |
| `type`                   | TINYINT      | The type of transaction.                                                    |
| `category_id`            | BIGINT       | **Foreign Key** to `transaction_category.category_id`.                      |
| `account_id`             | BIGINT       | **Foreign Key** to `account.account_id`.                                    |
| `transaction_time`       | BIGINT       | The timestamp of the transaction.                                           |
| `timezone_utc_offset`    | SMALLINT     | The UTC offset of the transaction's timezone.                               |
| `amount`                 | BIGINT       | The amount of the transaction.                                              |
| `related_id`             | BIGINT       | The ID of a related transaction.                                            |
| `related_account_id`     | BIGINT       | The ID of a related account.                                                |
| `related_account_amount` | BIGINT       | The amount in the related account.                                          |
| `hide_amount`            | BOOLEAN      | Whether to hide the transaction amount.                                     |
| `comment`                | VARCHAR(255) | Any comments about the transaction.                                         |
| `geo_longitude`          | DOUBLE       | The longitude where the transaction occurred.                               |
| `geo_latitude`           | DOUBLE       | The latitude where the transaction occurred.                                |
| `created_ip`             | VARCHAR(39)  | The IP address from which the transaction was created.                      |
| `scheduled_created`      | BOOLEAN      | Whether the transaction was created by a schedule.                          |
| `created_unix_time`      | BIGINT       | The timestamp when the transaction was created.                             |
| `updated_unix_time`      | BIGINT       | The timestamp when the transaction was last updated.                        |
| `deleted_unix_time`      | BIGINT       | The timestamp when the transaction was deleted.                             |

---

### `transaction_category`

The `transaction_category` table stores categories for transactions.

| Column             | Type        | Description                                                              |
| ------------------ | ----------- | ------------------------------------------------------------------------ |
| `category_id`      | BIGINT      | **Primary Key** - A unique identifier for each category.                 |
| `uid`              | BIGINT      | **Foreign Key** to `user.uid`.                                           |
| `deleted`          | BOOLEAN     | Whether the category is deleted.                                         |
| `type`             | TINYINT     | The type of category.                                                    |
| `parent_category_id`| BIGINT    | The ID of the parent category, if any.                                   |
| `name`             | VARCHAR(64) | The name of the category.                                                |
| `display_order`    | INT         | The order in which the category is displayed.                            |
| `icon`             | BIGINT      | The icon associated with the category.                                   |
| `color`            | VARCHAR(6)  | The color associated with the category.                                  |
| `hidden`           | BOOLEAN     | Whether the category is hidden.                                          |
| `comment`          | VARCHAR(255)| Any comments about the category.                                         |
| `created_unix_time`| BIGINT    | The timestamp when the category was created.                             |
| `updated_unix_time`| BIGINT    | The timestamp when the category was last updated.                        |
| `deleted_unix_time`| BIGINT    | The timestamp when the category was deleted.                             |

---

### `transaction_tag`

The `transaction_tag` table stores tags that can be applied to transactions.

| Column            | Type        | Description                                                              |
| ----------------- | ----------- | ------------------------------------------------------------------------ |
| `tag_id`          | BIGINT      | **Primary Key** - A unique identifier for each tag.                      |
| `uid`             | BIGINT      | **Foreign Key** to `user.uid`.                                           |
| `deleted`         | BOOLEAN     | Whether the tag is deleted.                                              |
| `name`            | VARCHAR(64) | The name of the tag.                                                     |
| `display_order`   | INT         | The order in which the tag is displayed.                                 |
| `hidden`          | BOOLEAN     | Whether the tag is hidden.                                               |
| `created_unix_time`| BIGINT    | The timestamp when the tag was created.                                  |
| `updated_unix_time`| BIGINT    | The timestamp when the tag was last updated.                             |
| `deleted_unix_time`| BIGINT    | The timestamp when the tag was deleted.                                  |

---

### `transaction_tag_index`

The `transaction_tag_index` table links transactions to tags in a many-to-many relationship.

| Column             | Type    | Description                                                                 |
| ------------------ | ------- | --------------------------------------------------------------------------- |
| `tag_index_id`     | BIGINT  | **Primary Key** - A unique identifier for each index entry.                 |
| `uid`              | BIGINT  | **Foreign Key** to `user.uid`.                                              |
| `deleted`          | BOOLEAN | Whether the index entry is deleted.                                         |
| `transaction_time` | BIGINT  | The timestamp of the transaction.                                           |
| `tag_id`           | BIGINT  | **Foreign Key** to `transaction_tag.tag_id`.                                |
| `transaction_id`   | BIGINT  | **Foreign Key** to `transaction.transaction_id`.                            |
| `created_unix_time`| BIGINT  | The timestamp when the index entry was created.                             |
| `updated_unix_time`| BIGINT  | The timestamp when the index entry was last updated.                        |
| `deleted_unix_time`| BIGINT  | The timestamp when the index entry was deleted.                             |

---

### `transaction_template`

The `transaction_template` table stores templates for creating transactions.

| Column                        | Type         | Description                                                                 |
| ----------------------------- | ------------ | --------------------------------------------------------------------------- |
| `template_id`                 | BIGINT       | **Primary Key** - A unique identifier for each template.                    |
| `uid`                         | BIGINT       | **Foreign Key** to `user.uid`.                                              |
| `deleted`                     | BOOLEAN      | Whether the template is deleted.                                            |
| `template_type`               | TINYINT      | The type of template.                                                       |
| `name`                        | VARCHAR(64)  | The name of the template.                                                   |
| `type`                        | TINYINT      | The type of transaction created by the template.                            |
| `category_id`                 | BIGINT       | **Foreign Key** to `transaction_category.category_id`.                      |
| `account_id`                  | BIGINT       | **Foreign Key** to `account.account_id`.                                    |
| `scheduled_frequency_type`    | TINYINT      | The frequency type for scheduled templates.                                 |
| `scheduled_frequency`         | VARCHAR(100) | The frequency for scheduled templates.                                      |
| `scheduled_start_time`        | BIGINT       | The start time for scheduled templates.                                     |
| `scheduled_end_time`          | BIGINT       | The end time for scheduled templates.                                       |
| `scheduled_at`                | SMALLINT     | The time at which the scheduled template runs.                              |
| `scheduled_timezone_utc_offset`| SMALLINT   | The UTC offset for the scheduled template's timezone.                       |
| `tag_ids`                     | VARCHAR(255) | A comma-separated list of tag IDs.                                          |
| `amount`                      | BIGINT       | The amount of the transaction.                                              |
| `related_account_id`          | BIGINT       | The ID of a related account.                                                |
| `related_account_amount`      | BIGINT       | The amount in the related account.                                          |
| `hide_amount`                 | BOOLEAN      | Whether to hide the transaction amount.                                     |
| `comment`                     | VARCHAR(255) | Any comments about the template.                                            |
| `display_order`               | INT          | The order in which the template is displayed.                               |
| `hidden`                      | BOOLEAN      | Whether the template is hidden.                                             |
| `created_unix_time`           | BIGINT       | The timestamp when the template was created.                                |
| `updated_unix_time`           | BIGINT       | The timestamp when the template was last updated.                           |
| `deleted_unix_time`           | BIGINT       | The timestamp when the template was deleted.                                |

---

### `token_record`

The `token_record` table stores authentication tokens.

| Column              | Type         | Description                                                                 |
| ------------------- | ------------ | --------------------------------------------------------------------------- |
| `uid`               | BIGINT       | **Primary Key** and **Foreign Key** to `user.uid`.                          |
| `user_token_id`     | BIGINT       | **Primary Key** - A unique identifier for each token.                       |
| `token_type`        | TINYINT      | The type of token.                                                          |
| `secret`            | VARCHAR(10)  | The token's secret.                                                         |
| `user_agent`        | VARCHAR(255) | The user agent associated with the token.                                   |
| `created_unix_time` | BIGINT       | **Primary Key** - The timestamp when the token was created.                 |
| `expired_unix_time` | BIGINT       | The timestamp when the token expires.                                       |
| `last_seen_unix_time`| BIGINT     | The timestamp when the token was last seen.                                 |

---

### `two_factor`

The `two_factor` table stores two-factor authentication information for users.

| Column            | Type        | Description                                                                 |
| ----------------- | ----------- | --------------------------------------------------------------------------- |
| `uid`             | BIGINT      | **Primary Key** and **Foreign Key** to `user.uid`.                          |
| `secret`          | VARCHAR(80) | The secret used for two-factor authentication.                              |
| `created_unix_time`| BIGINT    | The timestamp when two-factor authentication was enabled.                   |

---

### `two_factor_recovery_code`

The `two_factor_recovery_code` table stores recovery codes for two-factor authentication.

| Column            | Type        | Description                                                                 |
| ----------------- | ----------- | --------------------------------------------------------------------------- |
| `uid`             | BIGINT      | **Primary Key** and **Foreign Key** to `user.uid`.                          |
| `recovery_code`   | VARCHAR(64) | **Primary Key** - The recovery code.                                        |
| `used`            | BOOLEAN     | Whether the recovery code has been used.                                    |
| `created_unix_time`| BIGINT    | The timestamp when the recovery code was created.                           |
| `used_unix_time`  | BIGINT      | The timestamp when the recovery code was used.                              |

---

### `user_application_cloud_setting`

The `user_application_cloud_setting` table stores cloud settings for user applications.

| Column            | Type   | Description                                                                 |
| ----------------- | ------ | --------------------------------------------------------------------------- |
| `uid`             | BIGINT | **Primary Key** and **Foreign Key** to `user.uid`.                          |
| `settings`        | BLOB   | The user's application settings.                                            |
| `updated_unix_time`| BIGINT | The timestamp when the settings were last updated.                        |

---

### `user_custom_exchange_rate`

The `user_custom_exchange_rate` table stores custom exchange rates for users.

| Column            | Type       | Description                                                                 |
| ----------------- | ---------- | --------------------------------------------------------------------------- |
| `uid`             | BIGINT     | **Primary Key** and **Foreign Key** to `user.uid`.                          |
| `deleted_unix_time`| BIGINT   | **Primary Key** - The timestamp when the exchange rate was deleted.       |
| `currency`        | VARCHAR(3) | **Primary Key** - The currency for the exchange rate.                       |
| `rate`            | BIGINT     | The exchange rate.                                                          |
| `created_unix_time`| BIGINT   | The timestamp when the exchange rate was created.                           |
| `updated_unix_time`| BIGINT   | The timestamp when the exchange rate was last updated.                      |

---

### `transaction_picture_info`

The `transaction_picture_info` table stores information about pictures attached to transactions.

| Column              | Type        | Description                                                                 |
| ------------------- | ----------- | --------------------------------------------------------------------------- |
| `uid`               | BIGINT      | **Foreign Key** to `user.uid`.                                              |
| `deleted`           | BOOLEAN     | Whether the picture is deleted.                                             |
| `transaction_id`    | BIGINT      | **Foreign Key** to `transaction.transaction_id`.                            |
| `picture_id`        | BIGINT      | **Primary Key** - A unique identifier for each picture.                     |
| `picture_extension` | VARCHAR(10) | The file extension of the picture.                                          |
| `created_ip`        | VARCHAR(39) | The IP address from which the picture was uploaded.                         |
| `created_unix_time` | BIGINT      | The timestamp when the picture was uploaded.                                |
| `updated_unix_time` | BIGINT      | The timestamp when the picture was last updated.                            |
| `deleted_unix_time` | BIGINT      | The timestamp when the picture was deleted.                                 |
