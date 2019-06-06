# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|email|string|null: false, index: true, unique: true|
|password|string|null: false|

### Association
- has_many :groups, through: :members
- has_many :messages
- has_many :members

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :users, through: :members
- has_many :messages
- has_many :members

## messagesテーブル

|Column|Type|Options|
|------|----|-------|
|body|text||
|image|string||
|group|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user

## membersテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|group|references|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user