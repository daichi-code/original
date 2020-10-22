# README

## users テーブル
| Column        | Type      | Options     |
| ------------- | --------- | ------------|
| nick_name     | string    | null: false |
| email         | string    | null: false |
| password      | string    | null: false |
| first_name    | string    | null: false |
| last_name     | string    | null: false |
| birthday      | string    | null: false |

 - has_many :items
 - has_many :comments



## items テーブル
| Column       | Type         | Options                        |
| ------------ | ------------ | -------------------------------|
| title        | string       | null: false                    |
| text         | text         | null: false                    |
| year_id      | integer      | null: false                    |
| month_id     | integer      | null: false                    |
| category_id  | integer      | null: false                    |
| user         | references   | null: false, foreign_key: true |

### Association
 - belongs_to :user
 - has_many :comments



## comments テーブル
| Column | Type        | Options                        |
| ------ | ----------- | ------------------------------ |
| text   | text        | null: false                    |
| user   | references  | null: false, foreign_key: true |
| item   | references  | null: false, foreign_key: true |

### Association
 - belongs_to :user
 - belongs_to :item

