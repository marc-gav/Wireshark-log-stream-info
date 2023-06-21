#!/bin/bash

########################## Help message ##########################
if [ $# -lt 2 ] || [ $1 == "-h" ] || [ $1 == "--help" ]
then
  echo "Reads a pcap file and extracts streams"
  echo "See https://github.com/marc-gav/Wireshark-dump-stream-info for more information"
  echo ""
  echo "Usage: $0 [capture.pcap] [udp|tcp] [options] ..."
  echo "Options:"
  echo "    -h, --help            Show this help"
  echo "    -s, --select [list]   Select streams to process"
  echo "    -o, --output [path]   Output path to store the folder with the stream logs. Default is the current directory"
  echo ""
  echo "Examples:"
  echo "    $0 capture.pcap tcp"
  echo "    $0 capture.pcap tcp -s \"1,2,3\""
  echo "    $0 capture.pcap tcp -s \"2\""
  echo "    $0 capture.pcap tcp -o \"/home/user/streams\""
  echo ""
  exit 1
fi
#################################################################

########################## Options capture ######################
for ((i=1;i<=$#;i++));
do
  j=$((i+1))
  case ${!i} in
      -s|--select)
        select=${!j}
        echo "The stream selection has been modified to be: $select"
      ;;
      -o|--output)
        #j is the next argument
        output=${!j}
        echo "The output path has been modified to be: $output"
      ;;
      *)
            # unknown option
      ;;
  esac
done
#################################################################

############################ Asserts ############################
if [ ! -f $1 ] 
then
  echo "File $1 does not exist"
  exit 1
fi

if [ $2 != "udp" ] && [ $2 != "tcp" ] 
then
  echo "Protocol $2 not supported. Must be udp or tcp"
  exit 1
fi

if [ -z "$output" ]
then
  output_dir=$(pwd)
else
  output_dir=$output
fi
#################################################################

########################## Main script ##########################

## Arguments
p_cap_file=$1
protocol=$2

## Create output folder
folder_name=$protocol-$(date +%H:%M:%S_%Y-%m-%d)
echo "Storing stream logs in $output_dir/$folder_name"
mkdir $folder_name

## Get all streams ids
if [ $protocol == "tcp" ]
then
  all_streams=$(tshark -nlr $p_cap_file -Y tcp.flags.syn==1 -T fields -e tcp.stream | sort -n | uniq)
elif [ $protocol == "udp" ]
then
  all_streams=$(tshark -nlr $p_cap_file -Y udp -T fields -e udp.stream | sort -n | uniq)
else
  echo "Protocol $protocol not supported. Must be udp or tcp"
  exit 1
fi

## Filter them if necessary
if [ -z "$select" ]
then
  echo "No stream selection specified. Processing a total of: $(echo $all_streams | wc -w) streams"
else
  all_streams=$(echo $all_streams | tr " " "\n" | grep -wE "$select")
  echo "Processing streams: $all_streams"
fi

## Extract streams and store them in the output folder
for stream in $all_streams
do
  tshark -nlr $p_cap_file -qz "follow,$protocol,ascii,$stream" > $folder_name/stream-$stream.log
done
