updates=$(paru -Qu | wc -l)

echo '{"text": '$updates'}'
