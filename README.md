# Acme Widget Co - Shopping System

## Overview

This is an interactive command-line shopping system for Acme Widget Co that allows users to:

- Browse available products
- Add items to their basket
- View and add delivery charges
- Apply offers on eligible items

## Getting Started

### Prerequisites

Ruby 2.7+ (recommended 3.0+)

### Clone the repository:

```
git clone https://github.com/salmanx/acme-widget.git &&
cd acme-widget
```

### Key Classes

| Class            | Responsibility                                         |
| ---------------- | ------------------------------------------------------ |
| `Guide`          | Handles command-line interface and control flow        |
| `Product`        | Represents individual products and loads them from CSV |
| `BasketItem`     | Tracks a product and its quantity inside the basket    |
| `Basket`         | Applies offers and computes final basket total         |
| `DeliveryRules`  | Contains logic for tiered delivery fee                 |
| `RedWidgetOffer` | Implements discount logic for Red Widget special       |
| `Render`         | Formats and displays output to terminal                |
| `Config`         | Maps and validates user actions                        |

### Running the Application

Start the interactive guide:

```
ruby init.rb
```

### Running Tests

Assuming rspec installed globally

```
rspec
```

### User Guide

Available Commands

| Command                         | Shortcut  | Description                       | Example                  |
| ------------------------------- | --------- | --------------------------------- | ------------------------ |
| `list`                          | `L`       | Show all products                 | `list` or `L`            |
| `list by price` or `list price` | `L price` | Show all products sorted by price | `list` or `L`            |
| `rules`                         | `R`       | View delivery pricing rules       | `rules` or `R`           |
| `add`                           | `A`       | Add products to basket            | `add B01,R01` or `A G01` |
| `quit`                          | `Q`       | Exit the program                  | `quit` or `Q`            |

### User session

`>` Represents user input from command line

```
~/Documents/acme_widget/ ruby init.rb

Found the product csv file

<<< Welcome to  Acme Widget Co >>>

<<< This is an interactive guide to our new sale system >>>

AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> any

USE FOLLOWING COMMAND:

  list   (L): Show product list
  rules  (R): View pricing rules for delivery
  add    (A): Add items to basket
  quit   (Q): Exit program

AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> L

                     SHOW ALL PRODUCTS
------------------------------------------------------------
 Product                        Code                 Price
------------------------------------------------------------
 Red Widget                     R01                  $32.95
 Green Widget                   G01                  $24.95
 Blue Widget                    B01                  $7.95


------------------------------------------------------------
Sort using 'list name', 'list code', 'list by price'

AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> list by price

                     SHOW ALL PRODUCTS
------------------------------------------------------------
 Product                        Code                 Price
------------------------------------------------------------
 Blue Widget                    B01                  $7.95
 Green Widget                   G01                  $24.95
 Red Widget                     R01                  $32.95


------------------------------------------------------------
Sort using 'list name', 'list code', 'list by price'

AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> R

                 SHOW ALL DELIVERY CHARGES
------------------------------------------------------------
1. Delivery charge is $4.95. for orders under $50
2. Delivery charge is $2.95 for orders under $90
3. Delivery charge is free for orders of $90 or more

------------------------------------------------------------
AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> add

                   ADD PRODUCTS TO BASKET
------------------------------------------------------------
To add a product, write product_code, use comma for multiple products
Example: 'R01, G01, B01'

> B01, B01, R01, R01, R01

                SHOW ALL PRODUCTS IN BASKET
------------------------------------------------------------
 Product Code                             Total Price
------------------------------------------------------------
 B01,B01,R01,R01,R01                      $98.28


------------------------------------------------------------
AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> A

                   ADD PRODUCTS TO BASKET
------------------------------------------------------------
To add a product, write product_code, use comma for multiple products
Example: 'R01, G01, B01'

> B01, G01

                SHOW ALL PRODUCTS IN BASKET
------------------------------------------------------------
 Product Code                             Total Price
------------------------------------------------------------
 B01,G01                                  $37.85


------------------------------------------------------------
AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> add

                   ADD PRODUCTS TO BASKET
------------------------------------------------------------
To add a product, write product_code, use comma for multiple products
Example: 'R01, G01, B01'

> B01, R01, F01

ERROR: Product F01 not found

                SHOW ALL PRODUCTS IN BASKET
------------------------------------------------------------
 Product Code                             Total Price
------------------------------------------------------------
 B01,R01                                  $45.85


------------------------------------------------------------
AVAILABLE ACTIONS: list(L), rules(R), add(A), quit(Q)

> Q

<<< Good Bye, Happy shopping!! >>>

~/Documents/acme_widget/

```

### Contributing

Pull requests are welcome! Please open an issue first to discuss any changes.
