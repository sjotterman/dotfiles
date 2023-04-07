local M = {}

local function create_function_component(component_name, jsx, local_variables)
  local props_string = table.concat(local_variables, ", ")

  return [[
import React from 'react';

export const ]] .. component_name .. [[ = ({ ]] .. props_string .. [[ }) => {
  return (
    ]] .. jsx .. [[
  );
};
]]
end

local function extract_local_variables(jsx_lines)
  local local_variables = {}

  for _, line in ipairs(jsx_lines) do
    for variable in string.gmatch(line, "{([%w_]+%.?[%w_]*)}") do
      if not string.find(variable, "props") then
        local obj_prop = string.match(variable, "^([%w_]+)%.")
        if obj_prop then
          local_variables[obj_prop] = true
        else
          local_variables[variable] = true
        end
      end
    end
  end

  return local_variables
end

local function build_props_string(local_variables_array)
  local props_string_parts = {}
  for _, variable in ipairs(local_variables_array) do
    table.insert(props_string_parts, variable .. "={" .. variable .. "}")
  end
  return table.concat(props_string_parts, " ")
end

function M.extract_to_function_component()
  local bufnr = vim.api.nvim_get_current_buf()
  local component_name = "NewReactComponent"

  local start_line, end_line = vim.fn.getpos("'<")[2] - 1, vim.fn.getpos("'>")[2] - 1

  if start_line > end_line then
    print("Invalid selection.")
    return
  end

  local jsx_lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
  local jsx = table.concat(jsx_lines, "\n")

  local local_variables = extract_local_variables(jsx_lines)
  local local_variables_array = {}

  for variable, _ in pairs(local_variables) do
    table.insert(local_variables_array, variable)
  end

  local props_string = build_props_string(local_variables_array)
  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line + 1, false,
    { "<" .. component_name .. " " .. props_string .. " />" })

  -- Calculate the insertion point for the new component
  local insert_point = 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    if line:find("^import") then
      insert_point = i
    else
      break
    end
  end

  -- Create the new component and insert it in the original file
  local component_code = create_function_component(component_name, jsx, local_variables_array)
  local component_lines = vim.split(component_code, "\n")
  vim.api.nvim_buf_set_lines(bufnr, insert_point, insert_point, false, component_lines)
end

return M
