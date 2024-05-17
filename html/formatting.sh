#!/bin/bash
convert_name() {
    name="${1%.*}"
    name="${name//[_-]/ }"
    name="$(echo "$name" | sed -E 's/(^| )([a-z])/\1\u\2/g')"
    echo "$name"
}
echo "{" > assets.json
echo "    \"$1\": [" >> assets.json
while IFS=" -> " read -r id file; do
    name=$(convert_name "$file")
    echo '        {' >> assets.json
    echo '            "name": "'"$name"'",' >> assets.json
    echo '            "id": "'"$id"'"' >> assets.json
    echo '        },' >> assets.json
done < mappings.txt
sed -i '$s/,$//' assets.json
echo '    ]' >> assets.json
echo '}' >> assets.json
