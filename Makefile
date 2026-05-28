# Makefile
.PHONY: install prepare deploy destroy

# Переменная для передачи пароля Vault. 
# По умолчанию интерактивный запрос. Для CI можно передать файл: make deploy VAULT_ARGS="--vault-password-file=.vault_pass"
VAULT_ARGS ?= --ask-vault-pass

install:
	@cd ansible && ansible-galaxy install -r requirements.yml --force
	@cd ansible && ansible-galaxy collection install -r requirements.yml --force

prepare:
	@cd ansible && ansible-playbook -i inventory.yml playbook.yml --tags prepare $(VAULT_ARGS)

deploy:
	@cd ansible && ansible-playbook -i inventory.yml playbook.yml --tags deploy $(VAULT_ARGS)

destroy:
	@cd terraform && ./tf.sh destroy -auto-approve