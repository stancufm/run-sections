function fn_main_args(){
# Store number of arguments
args_number="$#"
# Declare vars
main_scope=""
# Get args from main scrips
#	If arg $1 from main script ( $4 for this function ) have -- then	
while echo $1 | grep -q ^--; do
	eval $( echo $1 | sed 's/^--//' )=$2
	eval main_scope=$( echo $1 | sed 's/^--//' )
	shift
	while echo $(eval echo $1) | grep -q ^[^--]; do 
		if [ "$( echo $2 | grep ^[^-])" ]; then
			eval $main_scope=\"\$$main_scope $2\"
		fi
		shift
	done
done

}
