.DEFAULT_GOAL := help

.PHONY: postgres jira confluence deps

RESET  = \033[0m
PURPLE = \033[0;35m
GREEN  = \033[0;32m
LINE   = $(PURPLE)-------------------------------------------------------------------------------------------------$(RESET)

###############################################################################
## BUILD Applications
###############################################################################
deps: # build dependancies
	docker network create atlassianNet

build-postgres: ## Build postgres docker image
	mkdir -p /opt/data/postgres
	cd postgres && docker build -t postgres .

build-jira: ## Build jira docker image
	mkdir -p /opt/data/jira
	cd jira && docker build -t jira .

build-confluence: ## Build confluence docker image
	mkdir -p /opt/data/confluence
	cd confluence && docker build -t confluence .

build-all: build-postgres build-jira build-confluence ## Build postgres, jira, and confluence

###############################################################################
## RUN SECTION
###############################################################################
postgres: ## Run the postgres docker image
	cd postgres && docker-compose up

jira: ## Run the jira docker image
	cd jira && docker-compose up

confluence: ## Run the confluence docker image
	cd confluence && docker-compose up

run-all: postgres jira confluence ## Run all containers

###############################################################################
## Bring down containers section
###############################################################################
down-postgres: ## Bring down postgres container
	cd postgres && docker-compose down -v --remove-orphans

down-jira: ## Bring down jira container
	cd jira && docker-compose down -v --remove-orphans

down-confluence: ## Bring down confluence container
	cd confluence && docker-compose down -v --remove-orphans


down-all: down-postgres down-jira down-confluence ## Bring down postgres, jira, and confluence


help: ## That's me!
	@echo
	@echo "#$(LINE)"
	@printf "\033[37m%-30s\033[0m %s\n" "# Makefile Help                                                                                  |"
	@echo "#$(LINE)"
	@printf "\033[37m%-30s\033[0m %s\n" "# This Makefile can be used to run, build, and tear down the atlassian suite (Confluence & Jira) |"
	@echo "#$(LINE)"
	@echo 
	@printf "\033[37m%-30s\033[0m %s\n" "#-target-----------------------description--------------------------------------------------------"
	@grep -E '^[a-zA-Z_-].+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo 

print-%  : ; @echo $* = $($*)

