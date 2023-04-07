local M = {}

local function create_function_component(component_name, jsx)
  return [[
import React from 'react';

export const ]] .. component_name .. [[ = (props) => {
  return (
    ]] .. jsx .. [[
  );
};
]]
end

function M.extract_to_function_component()
  local mode = vim.api.nvim_get_mode().mode
  local visual_mode = string.find("vV", mode) ~= nil

  if not visual_mode then
    print("Please select the JSX code in visual mode first.")
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local component_name = vim.fn.input("Component name: ")

  if component_name == "" then
    print("Component name cannot be empty.")
    return
  end

  local start_line, end_line = unpack(vim.api.nvim_buf_get_mark(bufnr, "<"), 1, 2)
  start_line, end_line = start_line - 1, end_line - 1
  local jsx_lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)

  local jsx = table.concat(jsx_lines, "\n")

  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line + 1, false, { "<" .. component_name .. " {...props} />" })
  local component_code = create_function_component(component_name, jsx)
  vim.api.nvim_command("edit " .. component_name .. ".jsx")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(component_code, "\n"))

  vim.api.nvim_command("write")
  vim.api.nvim_command("bwipeout")
end

return M
