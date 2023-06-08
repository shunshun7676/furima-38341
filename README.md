### users テーブル

| Column                      |Type     | Options                       |
|-----------------------------|-----------------------------------------|
| nickname                    | string  | null: false                   |
| email                       | string  | null: false, unique: true     |
| encrypteed_password         | string  | null: false                   |
| family_name                 | string  | null: false                   |
| first_name	                 | string	 | null: false                   |
| family_name_kana	           | string	 | null: false                   |
| first_name_kana	            | string	 | null: false                   |
| birthday	                   | date	   | null: false                   | 

- has_many :products
- has_many :purchases     

### productsテーブル

| Column             |Type       | Options                        |
|--------------------|-----------|--------------------------------|
| name	              |string	    |null: false                     |
|	explanation        |text	      |null: false                     |
| category_id	       |integer	   |null: false                     |
| derively_fee_id	   |integer	   |null: false                     |
| status_id	         |integer	   |null: false                     |
| prefecture_id	     |integer	   |null: false                     |
| hi_id              |integer    |null: false                     |
| price              |integer	   |null: false                     |
| user	              |references |null: false, foreign_key: true  |

- belongs_to :user
- has_one :purchase

### purchases テーブル

|Column	   |Type	      | Options                        |
|----------|-----------|--------------------------------|
|user	     |references	| null: false, foreign_key: true |
|product	  |references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :product
- has_one :address

### addresses テーブル 

|Column	       | Type	       |  Options                        |
|--------------|-------------|---------------------------------|
|post_code	    | string	     | null: false                     |
|prefecture_id |	integer	    | null: false                     |
|municipality	 | string	     | null: false                     |
|address	      | string	     | null: false                     |
|building_name |	string      |                                 |	
|phone_number  |	string	     | null: false                     |
|purchase      | references  | null: false, foreign_key: true  |

- belongs_to :purchase
