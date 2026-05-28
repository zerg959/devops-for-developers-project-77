.PHONY: setup code-setup terraform-init terraform-plan terraform-apply terraform-destroy

setup: code-setup terraform-init

code-setup:
	cd code/ansible && ansible-galaxy collection install -r requirements.yml --force

terraform-init:
	cd terraform && ./tf.sh init

terraform-plan:
	cd terraform && ./tf.sh plan

terraform-apply:
	cd terraform && ./tf.sh apply -auto-approve

terraform-destroy:
	cd terraform && ./tf.sh destroy -auto-approve