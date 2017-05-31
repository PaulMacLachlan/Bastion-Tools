# Yama_User_Create.rb

=begin
	an application that will take all Yama User request data as input and process it to output the the correct commands needed to create that user. It then PUTS that data to the screen, and COPIES it to the CLIPBOARD to expedite saving it externally within a text file.

	IDEAS FOR UPDATES:
	# can use this to create the Yama Username in a later update
	# refactor the repetative puts, gets.sub, repeat shenanigans
	# enable the application to accept the YubiKey .csv file to expedite.

=end

puts "Enter Config 1 Public String:"
strPublicID1 = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Config 1 Private String:"
strPrivateID1 = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Config 1 Secret String:"
strSecretID1 = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Config 2 Public String:"
strPublicID2 = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Config 2 Private String:"
strPrivateID2 = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Config 2 Secret String:"
strSecretID2 = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Full Name:"
strName = gets.chomp # converts input into string
puts "Enter email address:"
strEmail = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Employee Serial:"
strEmpSerial = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Office Location:"
strLoc = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Mobile phone number:"
strPhoneNum = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Country Code:"
strCountryCode = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Employee Type:"
strEmpType = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter YubiKey Serial Number:"
strYubiSerial = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Yama User ID Number:"
strUserIDNum = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Yama Username:"
strYamaUserName = gets.gsub(/\s+/, "") # converts input into string and removes whitespace

YamaGroups = []
puts "Enter requested Yama Groups:(enter group_name, or hit ENTER to continue)"
while (line = $stdin.readline) do
  break if line == "\n"
 YamaGroups << line.strip
end

# Next Section manipulates the inputted data

clean_output = Hash.new # hash for outputting keys with values on same line

clean_output["Public1"] = strPublicID1
clean_output["Private1"] = strPrivateID1
clean_output["Secret1"] = strSecretID1
clean_output["Public2"] = strPublicID2
clean_output["Private2"] = strPrivateID2
clean_output["Secret2"] = strSecretID2
clean_output["Email"] = strEmail
clean_output["Emp_Serial"] = strEmpSerial
clean_output["Emp_Location"] = strLoc
clean_output["Emp_Name"] = strName
clean_output["Emp_Phone_Number"] = strPhoneNum
clean_output["Yama_Groups"] = YamaGroups
clean_output["Country_Code"] = strCountryCode
clean_output["Employee_Type"] = strEmpType
clean_output["User_ID_Number"] = strEmpType
clean_output["Yubikey_Serial_Number"] = strYubiSerial

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

def pbpaste
  `pbpaste`
end

final_output =  <<MARKER
	Box Panel 2nd Factor data:
Public ID: #{strPublicID1}
Private ID: #{strPrivateID1} 
Secret ID: #{strSecretID1} 

	Yama 2nd Factor data: 
Yama Public ID: #{strPublicID2}
Yama Private ID: #{strPrivateID2} 
Yama Secret ID: #{strSecretID2} 

	User Add Script:
sudo useradd -u #{strUserIDNum} -c "#{strName}/#{strLoc}/IBM; #{strCountryCode}/#{strEmpType}/#{strEmpSerial}//#{strEmail}" -s /usr/local/bin/bash -m #{strYamaUserName}

	Access Database:
sudo sqlite3 /var/db/yubiauthd.sqlite

	Sqlite3 Statement:
INSERT into identities(public_id, serial_number, username, aes_key, uid) values('#{strPublicID2}', '#{strYubiSerial}', '#{strYamaUserName}', '#{strSecretID2}', '#{strPrivateID2}');

	Auth Proxy Database:
sudo sqlite3 /home/blueboxadmin/authorization_proxy.db

	Sqlite3 Statement:
INSERT INTO authorizations VALUES ('#{strYamaUserName}', (SELECT rowid FROM identities WHERE name='Yama_Group_Name'));

#{YamaGroups.join("\n")}

MARKER

puts final_output
# puts YamaGroups
pbcopy final_output

# yama_identities = "sudo sqlite3 /var/db/yubiauthd.sqlite" + "\n" + "INSERT into identities(public_id, serial_number, username, aes_key, uid) values('#{strPublicID2}', '#{strYubiSerial}', '#{strYamaUserName}', '#{strSecretID2}', '#{strPrivateID2}');"
# yama_groups = "sudo sqlite3 /home/blueboxadmin/authorization_proxy.db" + "\n" + "INSERT INTO authorizations VALUES ('#{strYamaUserName}', (SELECT rowid FROM identities WHERE name='#{strYamaGroups}'));"

# Script output example:

=begin
	
rescue 	Box Panel 2nd Factor data:
Public ID: 
Private ID: 
Secret ID: 

	Yama 2nd Factor data:
Yama Public ID: 
Yama Private ID: 
Yama Secret ID: 

	User Add Script:
sudo useradd -u  -c //IBM; //// -s /usr/local/bin/bash -m 

	Access Database:
sudo sqlite3 /var/db/yubiauthd.sqlite

	Sqlite3 Statement:
INSERT into identities(public_id, serial_number, username, aes_key, uid) values('', '', '', '', '');

	Auth Proxy Database:
sudo sqlite3 /home/blueboxadmin/authorization_proxy.db

	Sqlite3 Statement:
INSERT INTO authorizations VALUES ('', (SELECT rowid FROM identities WHERE name='')); => e
	
=end