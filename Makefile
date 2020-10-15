.DEFAULT_GOAL := help

.PHONY: postgres jira confluence nginx deps

RESET  = \033[0m
PURPLE = \033[0;35m
GREEN  = \033[0;32m
LINE   = $(PURPLE)-------------------------------------------------------------------------------------------------$(RESET)

###############################################################################
## BUILD Applications
###############################################################################
deps: # build dependencies
	docker network create atlassianNet

#build-postgres: ## Build postgres docker image (DEPRECATED)
#	mkdir -p /opt/data/postgres
#	cd postgres && docker build -t postgres .

#build-jira: ## Build jira docker image (DEPRECATED)
#	mkdir -p /opt/data/jira
#	cd jira && docker build -t jira .

#build-confluence: ## Build confluence docker image (DEPRECATED)
#	mkdir -p /opt/data/confluence
#	cd confluence && docker build -t confluence .

#build-all: build-postgres build-jira build-confluence ## Build postgres, jira, and confluence (DEPRECATED)

###############################################################################
## RUN SECTION
###############################################################################
postgres: ## Run the postgres image
	cd postgres && docker-compose up -d

jira: ## Run the jira image
	cd jira && docker-compose up -d

confluence: ## Run the confluence image
	cd confluence && docker-compose up -d

nginx: ## Run the nginx proxy
	cd nginx && docker-compose up -d

run-all: nginx postgres jira confluence ## Run all containers

###############################################################################
## Bring down containers section
###############################################################################
down-postgres: ## Bring down postgres container
	cd postgres && docker-compose down -v --remove-orphans

down-jira: ## Bring down jira container
	cd jira && docker-compose down -v --remove-orphans

down-confluence: ## Bring down confluence container
	cd confluence && docker-compose down -v --remove-orphans

down-nginx: ## Bring down nginx container
	cd nginx && docker-compose down -v --remove-orphans

down-all: down-postgres down-jira down-confluence down-nginx ## Bring down postgres, jira, and confluence


help: ## That's me!
	@echo
	@printf "\033[37m%-30s\033[0m %s\n" "#----------------------------------------------------------------------------------------"
	@printf "\033[37m%-30s\033[0m %s\n" "# Makefile Help                                                                         |"
	@printf "\033[37m%-30s\033[0m %s\n" "#-target-----------------------description-----------------------------------------------"
	@grep -h -E '^[a-zA-Z_-].+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

print-%  : ; @echo $* = $($*)

