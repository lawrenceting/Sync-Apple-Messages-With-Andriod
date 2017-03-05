property theURL : "syncmessages.herokuapp.com" & "/messages" --"localhost:3000"

using terms from application "Messages"
	
	on active chat message received msg from theBuddy for theChat with eventDescription
		messagereceived(msg, theBuddy)
	end active chat message received
	
	on message received msg from theBuddy for theChat with eventDescription
		messagereceived(msg, theBuddy)
	end message received
	
	on addressed message received msg from theBuddy for theChat with eventDescription
		messagereceived(msg, theBuddy)
	end addressed message received
	
	on chat room message received msg from theBuddy for theChat with eventDescription
		messagereceived(msg, theBuddy)
	end chat room message received
	
	on addressed chat room message received msg from theBuddy for theChat with eventDescription
		messagereceived(msg, theBuddy, "received")
	end addressed chat room message received
	
	on message sent msg for theChat with eventDescription
		set serviceId to id of (my getService(theChat))
		set serviceName to name of (my getService(theChat))
		set serviceType to service type of (my getService(theChat))
		
		try
			set forceError to theChat as string
		on error errStr number errorNumber
			set handleId to text 38 thru ((count errStr) - 19) of errStr
			--display dialog serviceId & ":" & handleId
		end try
	end message sent
	
	on messagereceived(msg, theBuddy)
		try
			set myId to get id of first service
			set serviceType to service type of first service
			set buddyid to id of theBuddy
			set theName to name of theBuddy
			set lastName to last name of theBuddy
			set fullname to full name of theBuddy
			set theHandle to handle of theBuddy
			set buddyService to service of theBuddy
			set msg to findandreplace of msg from "
" to "\\r\\"
			
			do shell script "curl -X POST -H " & quoted form of "Content-Type: application/json" & " -d " & quoted form of ("{" & Â
				"\"received\":" & true & "," & Â
				"\"delivered\":" & true & "," & Â
				"\"content\":\"" & msg & "\"," & Â
				"\"fullname\":\"" & fullname & "\"," & Â
				"\"buddyid\":\"" & buddyid & "\"" & "}") Â
				& space & theURL
		on error errStr number errorNum
			
		end try
	end messagereceived
	
	---------------------------------------------------------------------------------------------------------------------------
	# The following are unused but need to be defined to avoid an error
	---------------------------------------------------------------------------------------------------------------------------
	
	on received text invitation theText from theBuddy for theChat
	end received text invitation
	on received audio invitation theText from theBuddy for theChat
	end received audio invitation
	on received video invitation theText from theBuddy for theChat
	end received video invitation
	on received file transfer invitation theFileTransfer
	end received file transfer invitation
	on buddy authorization requested theRequest
	end buddy authorization requested
	on av chat started
	end av chat started
	on av chat ended
	end av chat ended
	on login finished for theService
	end login finished
	on logout finished for theService
	end logout finished
	on buddy became available theBuddy
	end buddy became available
	on buddy became unavailable theBuddy
	end buddy became unavailable
	on completed file transfer
	end completed file transfer
end using terms from

on getService(cht)
	local svc, cht
	tell application "Messages"
		repeat with svc in services
			try
				(first chat of svc whose it is cht)
				return contents of svc
			end try
		end repeat
	end tell
	return missing value
end getService

on findandreplace of t from s to r
	set d to text item delimiters
	set text item delimiters to s
	set t to t's text items
	set text item delimiters to r
	tell t to set t to beginning & ({""} & rest)
	set text item delimiters to d
	t
end findandreplace