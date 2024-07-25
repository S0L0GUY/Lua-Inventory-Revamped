--[[
A simple inventory management system that features read, update, delete, and add capabilities.
Made by Evan Grinnell

CARRD:
https://evan-grinnell.carrd.co/
]]

render = require("screen_manipulation_library")

function sleep(time)
  --[[
  time: integer, the amount of time that you want the program to pause for

  Pause the program for a specified time
  ]]
  os.execute("sleep " .. time)
end

function clear()
  --[[
  Clear the terminal
  ]]
  os.execute("clear")
end

function render_home()
  --[[
  Render the home page and its logic
  ]]
  clear()
  render.print_hedder()
  print([[
    1. Display product information
    2. Update
    3. Delete
    4. Add
    5. Exit
  ]])
  local user_input = tonumber(io.read())

  if type(user_input) ~= "number" then
    -- Checks to see that the user has inputted a number
    print("Sorry, that is not a number")
    sleep(3)
    render_home()
  elseif user_input > 5 or user_input < 1 then
    -- Checks that the user inputted a number within the range
    print("Sorry, " .. tostring(user_input) .. " is out of range")
    sleep(3)
    render_home()
  end

  -- Processes the user input
  if user_input == 1 then
    display_product_information()
  elseif user_input == 2 then
    update_item()
  elseif user_input == 3 then
    delete_item()
  elseif user_input == 4 then
    add_product()
  elseif user_input == 5 then
    exit()
  end
end

function table_contains(table, item)
  --[[
  table: string, the name of the table
  item: string, the item that you want to see if is in the table
  returns: boolean, the state of the item being in the table

  Check if (item) is in the (table) table
  ]]
  for key, value in pairs(table) do
    if value == item then
      return true
    end
  end
  return false
end

function find_item_index(table, item)
  --[[
  table: string, the name of the table
  item: string, the name of the item that you want to index
  returns: integer, the index of the item

  Get the index of (item) in (table)
  ]]
  for i, v in ipairs(table) do
    if v == item then
      return i
    end
  end
  return nil
end

function get_product_information(product_name)
  --[[
  product_name: string, the name of the product to search
  returns: table, product information

  Return the product price and quantity in a table
  ]]
  local item_index = find_item_index(item.name, product_name)
  local output = {}
  output["quantity"] = tostring(item.quantity[item_index])
  output["price"] = tostring(item.price[item_index])
  return output
end

function get_column_length(word_one, word_two, spaces)
  --[[
  word_one: string, the first word
  word_two: string, the second word
  spaces: integer, the amount of used spaces
  returnes: integer, the amount of total characters

  Return the length of all of the words and spaces added together
  ]]
  return string.len(tostring(word_one)) + string.len(tostring(word_two)) + spaces
end

function display_product_information()
  --[[
  Display a product's information based on its name
  ]]
  clear()
  render.print_hedder()

  print("What is the product name?")
  local user_input = string.upper(tostring(io.read()))

  if table_contains(item.name, user_input) then
    -- Checks that the user inputted a product that is in the inventory
    clear()
    render.print_hedder()
    print("Showing information for " .. user_input .. ".\n")

    -- Prints the product information
    local product_information = get_product_information(user_input)
    local column = {}
    column.one = get_column_length("quantity", product_information["quantity"], 10)
    column.two = get_column_length("price", tostring(product_information["price"]), 10)

    if (column.one - column.two) > 0 then
      diffrence_in_length = column.one - column.two
    else
      diffrence_in_length = column.two - column.one
    end

    -- Formats the columns to align
    if column.one > column.two then
      print("Item Quantity:" .. render.line(10, " ") .. tostring(product_information["quantity"]))
      print("Item Price:" .. render.line(diffrence_in_length + 10, " ") .. tostring(product_information["price"]))
    elseif column.one == column.two then
      print("Item Quantity:" .. render.line(10, " ") .. tostring(product_information["quantity"]))
      print("Item Price:" .. render.line(10, " ") .. tostring(product_information["price"]))
    else
      print("Item Quantity:" .. render.line(diffrence_in_length + 10, " ") .. tostring(product_information["quantity"]))
      print("Item Price:" .. render.line(10, " ") .. tostring(product_information["price"]))
    end

    print("\nPress ENTER to exit")
    io.read()
    render_home()
  else
    -- Prints the error message
    clear()
    render.print_hedder()
    print("Sorry, " .. user_input .. " is not listed under inventory")
    sleep(3)
    render_home()
  end
end

function add_product()
  --[[
  Add a product to the inventory
  ]]
  clear()
  render.print_hedder()
  local new_product = {}

  -- Gets the product name
  print("What is the product name?\n")
  new_product.name = string.upper(io.read())

  -- Checks to see that the item does not already exist
  if table_contains(item.name, new_product.name) then
    clear()
    render.print_hedder()
    print("Sorry, that item already exists")
    print("\nPress ENTER to exit")
    io.read()
    render_home()
  end
  -- Gets the product price
  clear()
  render.print_hedder()
  print("Product Name:    " .. new_product.name .. "\n")
  print("What is the unit price?\n")
  new_product.price = tonumber(io.read())

  -- Gets the produce quantity
  clear()
  render.print_hedder()
  print("Product Name:    " .. new_product.name)
  print("Unit Price:      " .. tostring(new_product.price) .. "\n")
  print("How many of this item do you have?\n")
  new_product.quantity = tonumber(io.read())

  -- Prints all of the new details
  clear()
  render.print_hedder()
  print("Product Name:    " .. new_product.name)
  print("Unit Price:      " .. tostring(new_product.price))
  print("Quantity:        " .. tostring(new_product.quantity) .. "\n")

  -- Adds all of the new data to the inventory
  table.insert(item.name, new_product.name)
  table.insert(item.price, new_product.price)
  table.insert(item.quantity, new_product.quantity)

  save_table_to_file(item, "inventory_contents.lua")

  print("Successfully added " .. new_product.name .. " to the inventory")
  print("\nPress ENTER to exit")
  io.read()
  render_home()
end

function delete_item()
  --[[
  Delete an item and its information from the inventory
  ]]
  clear()
  render.print_hedder()
  print("What is the item that you want to delete?")
  local item_name = string.upper(io.read())

  -- Checks to see that the user inputted a product that is in the inventory
  if table_contains(item.name, item_name) then
    -- Removes the item and its information from the inventory
    local item_index = find_item_index(item.name, item_name)
    table.remove(item.name, item_index)
    table.remove(item.price, item_index)
    table.remove(item.quantity, item_index)

    -- Saves the current state of the inventory
    save_table_to_file(item, "inventory_contents.lua")

    print("\nSuccessfully removed " .. item_name .. " from the inventory")
    print("\nPress ENTER to exit")
    io.read()
    render_home()
  else
    -- Prints the error message
    print("\nSorry, " .. item_name .. " is not listed in the inventory")
    sleep(3)
    render_home()
  end
end

function update_item()
  --[[
  Update any aspect of an item that exists in the inventory
  ]]
  clear()
  render.print_hedder()

  -- Gets the name of the item from the user
  print("What is the current name of the item that you want to edit?\n")
  local item_name = string.upper(io.read())

  -- Finds the items index
  local item_index = find_item_index(item.name, item_name)

  -- Checks to see the the chosen item already exists
  if table_contains(item.name, item_name) then
    clear()
    render.print_hedder()
    print("Product Name:    " .. item.name[item_index])
    print("Unit Price:      " .. tostring(item.price[item_index]))
    print("Quantity:        " .. tostring(item.quantity[item_index]) .. "\n")

    print("What would you like to edit?")
    print([[
      1. Item Name
      2. Item Price
      3. Item Quantity
    ]])

    local user_input = tonumber(io.read())

    if type(user_input) ~= "number" then
      -- Checks to see that the user has inputted a number
      print("Sorry, that is not a number")
      sleep(3)
      update_item()
    elseif user_input > 3 or user_input < 1 then
      -- Checks that the user inputted a number within the range
      print("Sorry, " .. tostring(user_input) .. " is out of range")
      sleep(3)
      update_item()
    end

    -- Handles the user decision
    if user_input == 1 then
      clear()
      render.print_hedder()
      print("Product Name:    " .. item.name[item_index])
      print("Unit Price:      " .. tostring(item.price[item_index]))
      print("Quantity:        " .. tostring(item.quantity[item_index]) .. "\n")
      print("What would you like to change the product name to?")
      local new_name = string.upper(io.read())

      -- Checks to see that the item does not already exist
      if table_contains(item.name, new_name) then
        clear()
        render.print_hedder()
        print("Sorry, that item already exists")
        print("\nPress ENTER to exit")
        io.read()
        render_home()
      end

      clear()
      render.print_hedder()

      item.name[item_index] = new_name

      save_table_to_file(item, "inventory_contents.lua")

      print("Successfully updated the item name to " .. item.name[item_index] .. ".")
      print("\nPress ENTER to exit")
      io.read()
      render_home()
    elseif user_input == 2 then
      clear()
      render.print_hedder()
      print("Product Name:    " .. item.name[item_index])
      print("Unit Price:      " .. tostring(item.price[item_index]))
      print("Quantity:        " .. tostring(item.quantity[item_index]) .. "\n")
      print("What would you like to change the product price to?")
      local new_price = tonumber(io.read())

      clear()
      render.print_hedder()

      item.price[item_index] = new_price

      save_table_to_file(item, "inventory_contents.lua")

      print("Successfully updated the item price to " .. tostring(item.price[item_index]) .. ".")
      print("\nPress ENTER to exit")
      io.read()
      render_home()
    elseif user_input == 3 then
      clear()
      render.print_hedder()
      print("Product Name:    " .. item.name[item_index])
      print("Unit Price:      " .. tostring(item.price[item_index]))
      print("Quantity:        " .. tostring(item.quantity[item_index]) .. "\n")
      print("What would you like to change the product quantity to?")
      local new_quantity = tonumber(io.read())

      clear()
      render.print_hedder()

      item.quantity[item_index] = new_quantity

      save_table_to_file(item, "inventory_contents.lua")

      print("Successfully updated the item quantity to " .. tostring(item.quantity[item_index]) .. ".")
      print("\nPress ENTER to exit")
      io.read()
      render_home()
    end
  else
    print("Sorry, " .. item_name .. " is not in the inventory")
    print("\nPress ENTER to exit")
    io.read()
    render_home()
  end
end

function serialize_table(table)
  --[[
  table: string, the name of the table that you want to serialize
  returns: string, the serialized table

  Serialize (table) and return the output
  ]]
  local function serialize(table, indent)
    --[[
    table: string, the name of the table
    indent: integer, the indention level of the serialized output
    returns: string, the serialized output of the table

    Serialize (table) with (indent) to make it easier to read
    ]]
    local serialized_string = "{\n"
    local indent_string = string.rep("  ", indent)
    for k, v in pairs(table) do
      local key = (type(k) == "string" and string.format("[%q]", k)) or ("[" .. k .. "]")
      local value
      if type(v) == "table" then
        value = serialize(v, indent + 1)
      elseif type(v) == "string" then
        value = string.format("%q", v)
      else
        value = tostring(v)
      end
      serialized_string = serialized_string .. indent_string .. "  " .. key .. " = " .. value .. ",\n"
    end
    return serialized_string .. indent_string .. "}"
  end

  return serialize(table, 0)
end

function save_table_to_file(table, file_name)
  --[[
  table: string, the table to save
  file_name: string, the directory to save the file to
  returns: boolean, if the operation was successful

  Save the contents of (table) to (file_name)
  ]]
  local file, err = io.open(file_name, "w")
  if not file then
    return false, err
  end
  file:write("return " .. serialize_table(table))
  file:close()
  return true
end

function load_table_from_file(file_name)
  --[[
  file_name: string, the name of the file that the table is located
  returns: table, the contence of the table

  Load the contence of a file and return it
  ]]
  local file, err = io.open(file_name, "r")
  if not file then
    return nil, err
  end

  local loaded_table = dofile(file_name)
  file:close()
  return loaded_table
end

function exit()
  --[[
  Save and close the program
  ]]
  save_table_to_file(item, "inventory_contence.lua")
  clear()
end

item = load_table_from_file("inventory_contence.lua")

render_home()
