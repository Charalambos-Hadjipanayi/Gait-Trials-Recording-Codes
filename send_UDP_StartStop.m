close all
clear
clc

% Note:
% Local host is the current host in which you are logged in. 
% Remote host is the host to which you are trying to connect from the local host .

%% Settings
Remote_HOST_IP = '192.168.0.14'; %IP of remote host computer (the remote (that is, host) IP address to which the data is sent)
UDP_PORT = 30; %Port Nexus is listening to (default is 30)
trialName='RemoteStartTrial';
FOLDER_PATH = 'C:\Users\chara\Documents\Vicon\';
PACKET_ID = 0;

time_pause=0; %Delay time between sending start and stop messages.

%% --------------Start UDP packet----------------------------------------------------------------------------------
% 
msg_start=append('<?xml version="1.0" encoding="UTF-8" standalone="no" ?><CaptureStart><Name VALUE="',trialName);
msg_start=append(msg_start,'"/><Notes VALUE=""/><Description VALUE=""/><DatabasePath VALUE="',FOLDER_PATH);
msg_start=append(msg_start,'"/><Delay VALUE="0"/><PacketID VALUE="',num2str(PACKET_ID),'"/></CaptureStart>');

% Notes:
% PACKET_ID  must increment by one every time a UDP packet is sent to Nexus, 
% Nexus will not accept a repeated command, or in other words, if you send two 
% different packets with the same ID number it will think they are the same. 
% So increment the number every time you send a message. 
% Also note that it is not required that the FOLDER_PATH be identical on both machines.

% ----------------------------------------------------------------------------------------------------------------

%% --------------Stop UDP packet-----------------------------------------------------------------------------------
% Stop UDP packet
msg_stop=append('<?xml version="1.0" encoding="UTF-8" standalone="no" ?><CaptureStop RESULT="SUCCESS"><Name VALUE="',trialName);
msg_stop=append(msg_stop,'"/><DatabasePath VALUE="',FOLDER_PATH);
msg_stop=append(msg_stop,'"/><Delay VALUE="0"/><PacketID VALUE="',num2str(PACKET_ID+1),'"/></CaptureStop>');

% Notes: 
%This is what the stop packet should contain. 
% Note how the PACKET_ID number is incremented from the start packet.
% ----------------------------------------------------------------------------------------------------------------

%% Pad the two messages to have the same length
targetLength=max(length(msg_start),length(msg_stop));	%must pad to equal length
msg_start = pad(msg_start,targetLength);
msg_stop = pad(msg_stop,targetLength);

%% Set-up the dsp.UDPReceiver System object
% Name and Value
%1.'RemoteIPAddress',character vector containing a valid IP address ('127.0.0.1' (default)  is the local host)
%2.'RemoteIPPort',25000 (default) | integer in the range [1, 65535]
udps = dsp.UDPSender('RemoteIPAddress',Remote_HOST_IP,'RemoteIPPort',UDP_PORT);

% Sending the packages
step(udps,uint8(msg_start));
pause(time_pause)
step(udps,uint8(msg_stop));

release(udps)