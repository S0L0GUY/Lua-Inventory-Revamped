# Simple Inventory Management System
This project provides a basic inventory management system implemented in Lua. It allows users to display, update, delete, and add products to an inventory. The program utilizes simple text-based interaction and file handling for storing inventory data.

# Features
Display Product Information: View details of a specific product including quantity and price.
Update Product Information: Modify existing product details such as name, price, or quantity.
Delete Product: Remove a product and its associated data from the inventory.
Add Product: Introduce new products to the inventory with details including name, price, and quantity.
Persistent Storage: Inventory data is saved to and loaded from a file.

# Requirements
Lua interpreter (version 5.1 or higher recommended).

# How to Use
Clone or download this repository.
Make sure you have Lua installed on your system.
Place main.lua, inventory_contents.lua, and screen_manipulation_library.lua in the same directory.
Run main.lua using the Lua interpreter.
Follow the on-screen prompts to manage your inventory.

# Files
main.lua: The primary script that contains the core logic for managing the inventory.
inventory_contents.lua: The Lua file that stores the inventory data in a table format.
screen_manipulation_library.lua: A custom module used for rendering and date functions.

# Functions
sleep(time): Pauses the program for a specified amount of time.
clear(): Clears the terminal screen.
render_home(): Displays the main menu and handles user navigation.
table_contains(table, item): Checks if an item is present in the given table.
find_item_index(table, item): Finds the index of an item in the table.
get_product_information(product_name): Retrieves the details of a specified product.
get_column_length(word_one, word_two, spaces): Computes the length required to display two columns of text.
display_product_information(): Shows detailed information of a product.
add_product(): Adds a new product to the inventory.
delete_item(): Removes a product from the inventory.
update_item(): Updates details of an existing product.
serialize_table(table): Serializes a table into a string format.
save_table_to_file(table, file_name): Saves the serialized table to a file.
load_table_from_file(file_name): Loads and deserializes the table from a file.
exit(): Saves the inventory data and closes the program.

# Adding New Products
To add new products, run the program and select the option to add a product. Provide the product name, price, and quantity when prompted. The data will be saved to inventory_contents.lua for future use.

# Inspiration
This project is a simple demonstration of Lua's file handling and text-based user interfaces. It was created to provide a straightforward solution for basic inventory management.

# Author
Evan Grinnell

# License
This project is open-source and free to use, modify, and distribute without any specific license.
