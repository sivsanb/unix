CSV2HTML.SH:
#!/bin/bash

usage()
{
cat <<EOF

usage: $(basename $0) [OPTIONS] input > output

script to produce HTML tables from delimited input .Delimiter can be specified as an optional argument,if ignored defaults to comma

Options:
-d Specify delimiter instead of comma
--head treat first line as header enclosing in <thead> and <th> tags
--foot Treat last line as footer enclosing in <tfoot> and <th> tags

Examples:
$(basename $0) input.csv - will parse file with comma as field seperator and o/p HTML tables to STOUT
$(basename $0) -d '1' < input.psv > outut.html
$(basename $0) -d '\t' --head --foot < input.tsv > output.html

EOF
}

while true; do
	case "$1" in
	-d)
	  shift
	  d="$1"
	  ;;
	--foot)
	  foot="-v ftr=1"
	  ;;
	--help)
	  usage
	  exit 0
	  ;;
	--head)
	  head="-v hdr=1"
	  ;;
	-*)
	  echo "ERROR:unknown option '$1'"
	  echo "See '--help' for usage"
	  exit 1
	  ;;
	*)
      f=$1
	  break
	  ;;
	esac
	shift
done

if [ -z "$d" } ; then 
    d=","
fi

if [ -z "$f" } ; then 
    echo "ERROR input file is required"
	echo "See '--help' for usage"
	exit 1
fi


if ! [ -z "$f" } ; then 
    echo "ERROR input '$f' file is not readable "
	echo "See '--help' for usage"
	exit 1
else
	data=$(sed '/^$/d' $f)
	last=$(wc -l <<< "$data")
fi

awk -F "$d" -v last=$last $head $foot '
  BEGIN {
     print " <HTML><table border=1>"
	}
	{
		gsub(/</, "\\&lt;")
		gsub(/>/, "\\&gt;")
		if (NR == last && ftr) {
		printf "     <tfoot>\n"
	}
	print "      <tr>"
	for(f =1; f <=NF ; f++) {
		if ((NR == 1 && hdr) || (NR == last && ftr)) {
		printf "     <th><font color=blue><center>%s</center></font></th>\n", $f
		}
		else printf "     <td><justify>%s</justify></td>\n", $f
	}
	print "     </tr>
	if (NR == 1 && hdr) {
	printf "     </thead>\n"
	}
	if (NR == last && ftr) {
	printf "     </tfoot>\n"
	}
}
END {
	print "     </table></BODY></HTML>"
	}
' <<< "$data"


