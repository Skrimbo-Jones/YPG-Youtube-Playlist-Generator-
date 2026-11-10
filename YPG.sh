#!/bin/bash
#Variables_1
savedchannels="SavedChannels.txt"
savedvideos="SavedVideos.txt"
#Functions
Exit()
{
	clear
	exit
}
SaveChannel()
{
	echo  "$channel_name" "$PLink" >> SavedChannels.txt
	echo "Saved."
}
Channel_Search()
{
	clear
	read -p "Enter Channel Name: " channel_name

	channel_id=$(curl -s -A "Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0" --compressed "https://www.youtube.com/@$channel_name" | grep -oP '(?<=externalId":")[^"]*(?=",)')
	PPFix="U"
	PPLink="${channel_id:0:1}${PPFix}${channel_id:2}"
	PFix="https://www.youtube.com/playlist?list="
	PLink="${PFix}${PPLink}"
	#echo "$channel_id"
	#echo "$PPLink"
	echo "$PLink"
	read -p "Press 1 to save channel. Press 2 to exit to main menu. 1/2 " Save_Choice_Channel
	if [ $Save_Choice_Channel -eq 1 ]; then
		SaveChannel
	fi
	if [ $Save_Choice_Channel -eq 2 ]; then
		echo "Exiting...Press Any Key"
	fi

	read
}
LikeVideo()
{
	clear
	read -p "Paste Video URL to Save: " Liked_Video
	read -p "Type the title:" Liked_Video_Title
	read -p "Type the video uploader's name: " Liked_Video_Uploader
	echo "$Liked_Video_Title $Liked_Video $Liked_Video_Uploader" >> SavedVideos.txt
	echo "Saved."
}
Saved_Channels()
{
	clear
	echo "Loading..."
	echo "Press q to exit to main menu."
	sleep 5
	clear
	less -FX "SavedChannels.txt"
	read
}
Saved_Videos()
{
	clear
	echo "Loading..."
	echo "Press q to exit to main menu."
	sleep 5
	clear
	less -FX "SavedVideos.txt"
	read
}
#Variables_2
z=1
#Main

echo "Checking for required programs..."
sleep 2
if ! command -v curl &> /dev/null
then
    echo 'curl is not installed. Please install by typing "sudo apt install curl -y".'
    exit
fi
while [ $z -eq 1 ];
do
	clear
	echo "OurTube"
	echo "Pick an option:"
	echo "1.Search"
	echo "2.Saved Channels"
	echo "3.Saved Videos"
	echo "4.Like A Video"
	echo "5.Exit"
	read -p "" Main_Choice
	if [ $Main_Choice -eq 1 ]; then
		Channel_Search
	fi
	if [ $Main_Choice -eq 2 ]; then
		Saved_Channels
	fi
	if [ $Main_Choice -eq 3 ]; then
		Saved_Videos
	fi
	if [ $Main_Choice -eq 4 ]; then
		LikeVideo
	fi
	if [ $Main_Choice -eq 5 ]; then
		Exit
	fi

done