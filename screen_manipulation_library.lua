local M = {}

function M.line(length, character)
  --[[
  length: integer, the amount of times you want the line to repeat the requested character
  character: string, the character that you want repeated
  returns: string, the created line

  Create a line of this length with this character
  ]]
  local output = ""
  for i = 1, length do
    output = output .. character
  end
  return output
end

function M.update_current_date()
  --[[
  returns: table, the current date

  Update the current date
  ]]
  return os.date("*t")
end

function M.date()
  --[[
  returns: string, formatted date

  Format the current date and return it as a string
  ]]
  local currentDate = M.update_current_date()
  return currentDate.month .. "/" .. currentDate.day .. "/" .. currentDate.year
end

function M.print_hedder()
  --[[
  Print the program header
  ]]
  print("Lua Inventory" .. M.line(40, " ") .. M.date() .. "\n" .. M.line(62, "-"))
end

return M
