# Bastion-Tools
Tools for administering users in YAMA/BASTION

YamaUserCreate.rb - Utilizing the data provided from the access request templates, this script will format the data and provide you output with preformatted script and sql commands. Further, it utilizes pbcopy to drop that output into the clipboard, making it easy to paste the data into a txt file for record keeping.
  NOTE: Depending on the availability and use of this script, it could be susceptible to Sql injection, and was not designed for use beyond a single users desktop. This should be kept in mind going forward.

yubiClean.rb - is a very simple script that simply removed the whitespace that you get when copying the data from the Yubikey Personalization Tool. The white space is annoying when you need to drop the data into Auth or into Bastions.
