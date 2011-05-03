note
	description : "Objects that represent an log tracer"
	date        : "$Date$"
	revision    : "$Revision$"

class
	FILE_LOGGER

inherit
	LOGGER
		redefine
			close
		end

create
	make,
	make_with_filename

feature {NONE} -- Initialization

	make (f: FILE)
		do
			name := f.name
			file := f
		end

	make_with_filename (fn: STRING)
		do
			name := fn
			file := Void
		end

	file: detachable FILE

	name: STRING

feature -- Access

	log (a_level: INTEGER; m: STRING)
		local
			f: like file
			b: BOOLEAN
		do
			f := file
			if f = Void then
				b := True
				create {PLAIN_TEXT_FILE} f.make_open_append (name)
			end
			f.put_string (m)
			f.put_string ("%N")
			f.flush
			if b then
				f.close
			end
		end

	close
		do
			Precursor
			if attached file as f and then not f.is_closed then
				f.close
			end
		end

end
