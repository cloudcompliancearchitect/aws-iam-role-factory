.PHONY: init plan apply destroy fmt validate

init:
	cd examples/auditor && terraform init

plan:
	cd examples/auditor && terraform plan

apply:
	cd examples/auditor && terraform apply -auto-approve

destroy:
	cd examples/auditor && terraform destroy -auto-approve

fmt:
	terraform fmt -recursive

validate:
	terraform validate
