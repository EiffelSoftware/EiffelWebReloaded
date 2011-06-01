deferred class
	REST_APPLICATION_GATEWAY

inherit
	HTTPD_NINO_APPLICATION
		redefine
			initialize_server
		end

feature -- Access

	initialize_server
		do
			Precursor
			base := ""
			server.configuration.http_server_port := 80
			server.configuration.force_single_threaded := True
		end

	base: detachable STRING

	gateway_name: STRING = "NINO"

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
