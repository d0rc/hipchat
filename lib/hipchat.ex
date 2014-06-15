defmodule Hipchat do
	defp auth do
		Sweetconfig.get([:hipchat, :auth])
	end
	def query(endpoint) do
		case HTTPoison.get "https://api.hipchat.com/v2/#{endpoint}#{auth}" do
			%HTTPoison.Response{status_code: 200, body: body} -> Jazz.decode!(body)
			_ -> :error
		end
	end
	def query(endpoint, json) do
		case HTTPoison.post "https://api.hipchat.com/v2/#{endpoint}#{auth}", Jazz.encode!(Enum.into(json, %{})), [{"content-type", "application/json"}] do
			%HTTPoison.Response{status_code: 200} -> :ok
			%HTTPoison.Response{status_code: 204} -> :ok
			response ->
				IO.puts "#{inspect response}"
		end
	end
	def message(room_id, msg), do: query("room/#{room_id}/notification", [message: msg, notify: true])
	def info(room_id, msg), do: query("room/#{room_id}/notification", [message: msg, color: "green"])
end
