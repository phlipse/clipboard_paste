(*
Write clipboard content character by character to input-device.
*)

set input to do shell script "pbpaste"						-- get string from clipboard / input = clipboard
if (input is not missing value) then						-- if input not null, do
	tell application "System Events"						-- call System Events
		repeat with char in the characters of input			-- for character in input, do
			keystroke char 									-- write character
		end repeat
	end tell
end if