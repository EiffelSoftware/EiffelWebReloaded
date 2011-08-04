note
	description : "Objects that handle error..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_HANDLER

inherit
	ANY

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create {ARRAYED_LIST [ERROR]} errors.make (3)
		end

feature -- Status

	has_error: BOOLEAN
			-- Has error?
		do
			Result := count > 0
		end

	count: INTEGER
		do
			Result := errors.count
		end

	errors: LIST [ERROR]
			-- Errors container

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			if has_error then
				Result := count.out +  " errors"
			else
				Result := "no error"
			end
		end

feature -- Basic operation

	add_error (a_error: ERROR)
			-- Add `a_error' to the stack of error
		do
			errors.force (a_error)
		end

	add_error_details, add_custom_error (a_code: INTEGER; a_name: STRING; a_message: detachable STRING_32)
			-- Add custom error to the stack of error
		local
			e: ERROR_CUSTOM
		do
			create e.make (a_code, a_name, a_message)
			add_error (e)
		end

	append (a_err_handler: ERROR_HANDLER)
			-- Append errors from `a_err_handler'
		do
			errors.append (a_err_handler.errors)
		end

feature -- Access

	as_single_error: detachable ERROR
		do
			if count > 1 then
				create {ERROR_GROUP} Result.make (errors)
			elseif count > 0 then
				Result := errors.first
			end
		ensure
			has_error_implies_result_attached: has_error implies Result /= Void
		end

	as_string_representation: STRING
		require
			has_error
		do
			if attached as_single_error as e then
				Result := e.string_representation
			else
				check has_error: False end
				Result := "Error occured"
			end
		end

feature -- Element changes

	concatenate
			-- Concatenate into a single error if any
		do
			if count > 1 and then attached as_single_error as e then
				wipe_out
				add_error (e)
			end
		end

	reset, wipe_out
		do
			errors.wipe_out
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
