set -e
score=$(bundle exec rubycritic app --no-browser -f lint | awk 'END{ print $2 * 1.0 }')
echo $score
if [[ $(echo "$score > 90.00" | bc -l) -eq 0 ]] ; then
	echo "Score is below threshold" 1>&2
	exit 1
fi

