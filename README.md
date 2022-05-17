# テーブル設計

## users テーブル
foreign_key: true
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| name               | string | null: false |
| profile            | text   | null: false |
| occupation         | text   | null: false |
| position           | text   | null: false |
### Association

- has_many :comments
- has_many :prototypes

## comments テーブル
| Column             | Type      | Options                      |
| ------------------ | ------    | -----------------------------|
| content            | string    | null: false                  |
| prototype          | reference | null: false,foreign_key: true|
| user               | reference | null: false,foreign_key: true|

### Association

- belongs_to :user
- belongs_to :prototype 


## prototypes テーブル
| Column             | Type      | Options                      |
| ------------------ | ------    | -----------------------------|
| title              | string    | null: false                  |
| catch_copy         | text      | null: false,                 |
| concept            | text      | null: false,                 |
| user               | reference | null: false,foreign_key: true|

### Association

- belongs_to :user
- has_many   :comments