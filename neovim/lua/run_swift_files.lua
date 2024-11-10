-- Trying this solution -> https://stackoverflow.com/a/75240496

vim.api.nvim_create_autocmd("BufWritePost", {
   group = vim.api.nvim_create_augroup("SwiftFilesRunner", { clear = true }),
   pattern = "*.swift",
   callback = function()
	   vim.schedule(function()
		   local buffer_number = 0
		   local file_name = vim.api.nvim_buf_get_name(0)

		   local append_data = function(_, data)
			   if data then
				   vim.api.nvim_buf_set_lines(buffer_number, -1, -1, false, data)
			   end
		   end

		   vim.api.nvim_buf_set_lines(buffer_number, 0, -1, false, { "Swift file output:" })

		   vim.fn.jobstart( { "swift", file_name }, {
			   stdout_buffered = true,
			   on_stdout = append_data,
			   on_stderr = append_data
		   })
	   end)
   end
})

--print("start run swift files")

-- local buffer_number = -1
--
-- local function log(_, data)
-- 	print("inside log")
-- 	if data then
-- 		-- Make it temporarily writable so we don't have warnings.
-- 		vim.api.nvim_buf_set_option(buffer_number, "readonly", false)
--
-- 		-- Append the data.
-- 		vim.api.nvim_buf_set_lines(buffer_number, -1, -1, true, data)
--
-- 		-- Make readonly again.
-- 		vim.api.nvim_buf_set_option(buffer_number, "readonly", true)
--
-- 		-- Mark as not modified, otherwise you'll get an error when
-- 		-- attempting to exit vim.
-- 		vim.api.nvim_buf_set_option(buffer_number, "modified", false)
--
-- 		-- Get the window the buffer is in and set the cursor position to the bottom.
-- 		local buffer_window = vim.api.nvim_call_function("bufwinid", { buffer_number })
-- 		local buffer_line_count = vim.api.nvim_buf_line_count(buffer_number)
-- 		vim.api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
-- 	end
-- end
--
-- local function open_buffer()
-- 	print("inside open_buffer")
-- 	-- Get a boolean that tells us if the buffer number is visible anymore.
-- 	--
-- 	-- :help bufwinnr
-- 	local buffer_visible = vim.api.nvim_call_function("bufwinnr", { buffer_number }) ~= -1
--
-- 	if buffer_number == -1 or not buffer_visible then
-- 		-- Create a new buffer with the name "AUTOTEST_OUTPUT".
-- 		-- Same name will reuse the current buffer.
-- 		-- vim.api.nvim_command("botright split AUTOTEST_OUTPUT")
-- 		vim.api.nvim_command("botright 10.split AUTOTEST_OUTPUT")
--
-- 		-- Collect the buffer's number.
-- 		buffer_number = vim.api.nvim_get_current_buf()
--
-- 		-- Mark the buffer as readonly.
-- 		vim.opt_local.readonly = true
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	group = vim.api.nvim_create_augroup("SwiftFilesRunner", { clear = true }),
-- 	pattern = "*.swift",
-- 	callback = coroutine.create(function()
-- 		local file_name = vim.api.nvim_buf_get_name(0)
--
-- 		-- Open our buffer, if we need to.
-- 		open_buffer()
--
-- 		-- Clear the buffer's contents incase it has been used.
-- 		vim.api.nvim_buf_set_lines(buffer_number, 0, -1, true, { "Output of '", file_name, "':" })
--
-- 		-- Run the command.
-- 		vim.fn.jobstart({ "swift", file_name }, {
-- 			stdout_buffered = true,
-- 			on_stdout = log,
-- 			on_stderr = log,
-- 		})
-- 	end)()
-- })
--
