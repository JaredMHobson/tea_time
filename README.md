# The Sunken Isles First Mate

## Table of Contents
- [Getting Started](#getting-started)
- [Project Description](#project-description)
- [End Points](#end-points)
- [Contributors](#contributors)

## Getting Started
### Versions
- Ruby: 3.2.2
- Rails: 7.1.3

## Project Description

Tea Time is a simple API that lets you start and cancel a tea subscription for a customer and retrieve all tea subscriptions that a customer has had.  

This app was designed and built by myself as part of the [intermission work](https://mod4.turing.edu/projects/take_home/take_home_be), from Turing School of Software and Design.

<details>
  <summary>Key Skills to Demonstrate</summary>

- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation
</details>

<details>
  <summary>Setup</summary>

  1. Fork and/or Clone this Repo from GitHub.
  2. In your terminal use `$ git clone <ssh or https path>`.
  3. Change into the cloned directory using `$ cd example`.
  4. Install the gem packages using `$ bundle install`.
  5. Database Migrations can be set up by running: 
  ``` bash 
  $ rails db:{drop,create,migrate,seed}
  ```
</details>

<details>
  <summary>Testing</summary>

  Test using the terminal utilizing RSpec:

  ```bash
  $ bundle exec rspec spec/<follow directory path to test specific files>
  ```

  or test the whole suite with `$ bundle exec rspec`

  Test Results as of 6/29/24: 100.0%
</details>

<details>
  <summary>Database Schema</summary>

```
ActiveRecord::Schema[7.1].define(version: 2024_06_27_232609) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_id", null: false
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_subscriptions_on_customer_id"
    t.index ["subscription_id"], name: "index_customer_subscriptions_on_subscription_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.integer "status"
    t.integer "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "temperature"
    t.integer "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customer_subscriptions", "customers"
  add_foreign_key "customer_subscriptions", "subscriptions"
end
```
</details>

## End Points
### Customer Subscriptions
<details>
<summary> Create CustomerSubscription </summary>

Request:

```http
POST /api/v1/customer_subscriptions
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{ 
    "customer_subscription": 
        {
             "customer_id": 1,
             "subscription_id": 3
        }
 }
```

Response: `status: 201`

```json
{
    "data": {
        "id": "1",
        "type": "customer_subscription",
        "attributes": {
            "status": "active",
            "title": "It's Tea",
            "price": 5000,
            "frequency": 3
        },
        "relationships": {
            "customer": {
                "data": {
                    "id": "1",
                    "type": "customer"
                }
            },
            "subscription": {
                "data": {
                    "id": "3",
                    "type": "subscription"
                }
            }
        }
    }
}
```
</details>

<details>
<summary> Cancel/Reactivate CustomerSubscription </summary>

Request:

```http
PATCH api/v1/customer_subscriptions/1
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
    "status": "cancelled"
}
```

Response: `status: 200`

```json
{
    "data": {
        "id": "1",
        "type": "customer_subscription",
        "attributes": {
            "status": "cancelled",
            "title": "It's Tea",
            "price": 5000,
            "frequency": 3
        },
        "relationships": {
            "customer": {
                "data": {
                    "id": "1",
                    "type": "customer"
                }
            },
            "subscription": {
                "data": {
                    "id": "3",
                    "type": "subscription"
                }
            }
        }
    }
}
```
</details>

<details>
<summary> Get All CustomerSubscriptions for a Customer </summary>

Request:

```http
GET /api/v1/customer_subscriptions/1
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
    "data": [
        {
            "id": "1",
            "type": "customer_subscription",
            "attributes": {
                "status": "active",
                "title": "Expensive Tea",
                "price": 10000,
                "frequency": 1
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "1",
                        "type": "customer"
                    }
                },
                "subscription": {
                    "data": {
                        "id": "1",
                        "type": "subscription"
                    }
                }
            }
        },
        {
            "id": "2",
            "type": "customer_subscription",
            "attributes": {
                "status": "active",
                "title": "Least Expensive Tea",
                "price": 100,
                "frequency": 12
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "1",
                        "type": "customer"
                    }
                },
                "subscription": {
                    "data": {
                        "id": "2",
                        "type": "subscription"
                    }
                }
            }
        },
        ...,
        ...
    ]
}
```

This endpoint also accepts query params to filter subscriptions with a status of active or cancelled.

Example:
```http
GET /api/v1/customer_subscriptions/1?status=cancelled
Content-Type: application/json
Accept: application/json
```

or

```http
GET /api/v1/customer_subscriptions/1?status=active
Content-Type: application/json
Accept: application/json
```
</details>

## Contributors

* Jared Hobson | [GitHub](https://github.com/JaredMHobson) | [LinkedIn](https://www.linkedin.com/in/jaredhobson/)
