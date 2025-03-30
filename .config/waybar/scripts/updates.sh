#yay -Sy

updates=$(yay -Qu | wc -l)

echo '{"text": '$updates'}'
