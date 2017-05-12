fn_run_sections() {
	all_sections=($(sed -n "/^#:start:/{p;};" $0 | grep ':$' | awk -F: '{print $3}' | sort -u))
	display_usage(){
		echo "Usage: $0:"
		echo -e "\t[options and commands] [-- [extra args]]"
		echo -e "OPTIONS:\n"
		echo -e "\t-h,--help\t\t\t\tDisplay this help"
		echo -e "\t-s,--section \"example\"\t\t\tExecute just the code from this section"
		echo -e "\t\t\t\t\t\tUse in your script \"#:start:example:\" - marks the beggining of the section"
		echo -e "\t\t\t\t\t\tUse in your script \"#:end:example:\" - marks the ending of the section"
		echo -e "\t\t\t\t\t\tUse in your script \"#:start:INIT:\" - marks INIT section wich will run always first"
		echo -e "\t\t\t\t\t\tUse in your script \"#:end:INIT:\" - makrs the ending of INIT section"
		echo -e "\t-s,--section \"all\"\t\t\tExecute the entire script!"
		echo -e "\tSECTIONS AVAILABLE: \t\t\t${all_sections[@]}"
	}
	# Passing Usage:
	if [ $args_number -lt 2 ];then
		display_usage
		exit
	elif [ "$section" = "all" ];then
		echo -e "\e[33mRunning All Sections;\e[0m"
	elif [ -n "$section" ];then
		# INIT sesctions must always RUN first
		run_init=$(sed -ne "/^#:start:INIT:/, /#:end:INIT:$/p;" $0 | grep -v ':$')
		eval "$run_init"

		# For other sections use script_name.sh --section <section_name>
		# Declare sections inside script with #:start:section_name:
		# Mark where you what to end your sesction with #:end:section_name
		declare -a sections=($(echo $section))
		for section in "${sections[@]}"; do
			if [ -n "$(echo ${all_sections[@]} | grep $section)" ];then
				echo -e "\e[33mStarting SECTION:\033[1m $section\033[0m;\e[0m"
				cmd2run=$(sed -ne "/^#:start:$section:/, /#:end:$section:$/p;" $0 | grep -v ':$')
				eval "$cmd2run"
				echo -e "\e[33mEnd SECTION:\033[1m $section\033[0m;\e[0m"
			else
				echo -e "ERROR: Section \033[1m $section\033[0m NOT FOUND!"
				echo -e "INFO: Skipping \033[1m $section\033[0m"
				echo -e "SECTIONS AVAILABLE:\t ${all_sections[@]}"
			fi
		done
		exit
	else
		display_usage
		exit
	fi
}
