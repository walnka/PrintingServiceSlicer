#!/bin/bash

SLIC3R_DIR=~/AppImages/Slic3r
STL_DIR=STL
GCODE_DIR=GCODE
CONFIG_DIR=CONFIG
POSTPROCESS_DIR=$SLIC3R_DIR/utils/post-processing

quote=''

print_usage() {
  printf "To slice a file include the following flags and filenames:\n"
  printf "-c configfilename.ini (this is the name of the config file in the CONFIG folder)\n"
  printf "-i inputfilename.stl (this is the name of the stl to be sliced in the STL folder)\n"
  printf "-o outputfilenmae.gcode (this is the name of the gcode to be output in the GCODE folder)\n\n"
}


while getopts 'c:i:o:q'  flag; do
  case "${flag}" in
    c) 	if [[ ${OPTARG} == *".ini" ]]
	then
	   config="$CONFIG_DIR/${OPTARG}"
	elif [[ ${OPTARG} == *"."* ]]
	then
	   echo "Wrong File Type. Config (-c) should be *.ini"
	   exit 1
	else
	   config="$CONFIG_DIR/${OPTARG}.ini" 
	fi
	;;
    i) if [[ ${OPTARG} == *".stl" ]]
        then
           stl="$STL_DIR/${OPTARG}"
        elif [[ ${OPTARG} == *"."* ]]
        then
	   echo "Wrong File Type. Input (-i) should be *.stl"
           exit 1
	else
           stl="$STL_DIR/${OPTARG}.stl" 
        fi
	;;
    o) if [[ ${OPTARG} == *".gcode" ]]
        then
           gcode="$GCODE_DIR/${OPTARG}"
        elif [[ ${OPTARG} == *"."* ]]
        then
	   echo "Wrong File Type. Output (-o) should be *.gcode"
           exit 1
	else
           gcode="$GCODE_DIR/${OPTARG}.gcode" 
        fi
	;;
    q) quote="--post-process $POSTPROCESS_DIR/filament-weight.pl"
	;; 
    *) print_usage
       exit 1 ;;
  esac
done
printf "Running:\nperl %s/slic3r.pl --load %s -o %s %s %s\n" $SLIC3R_DIR $config $gcode $quote $stl
perl $SLIC3R_DIR/slic3r.pl --load $config -o $gcode $quote $stl
