echo ">>> insert the fact you want to retrieve:"; \
read fact ; \
ansible -i hosts all \
	-m setup |cut -d\> -f 2 | \
	jq -Mr .ansible_facts.${fact}
