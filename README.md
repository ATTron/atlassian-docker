# Atlassian Docker Suite
Confluence + Jira running inside docker containers with postgresql

## USAGE
Use the Makefile to navigate  
```
:$make


#-------------------------------------------------------------------------------------------------
# Makefile Help                                                                                  |
#-------------------------------------------------------------------------------------------------
# This Makefile can be used to run, build, and tear down the atlassian suite (Confluence & Jira) |
#-------------------------------------------------------------------------------------------------

#-target-----------------------description--------------------------------------------------------
build-all                      Build postgres, jira, and confluence
build-confluence               Build confluence docker image
build-jira                     Build jira docker image
build-postgres                 Build postgres docker image
confluence                     Run the confluence docker image
down-all                       Bring down postgres, jira, and confluence
down-confluence                Bring down confluence container
down-jira                      Bring down jira container
down-postgres                  Bring down postgres container
help                           That's me!
jira                           Run the jira docker image
postgres                       Run the postgres docker image
run-all                        Run all containers

```

BUILD THE DEPENDENCIES FIRST  
``` make deps ```

IT IS REQUIRED TO HAVE POSTGRES RUNNING IN ORDER FOR CONFLUENCE + JIRA TO FUNCTION AS EXPECTED  
``` make postgres ```  

THEN START YOUR OTHER SERVICES  
``` make jira ```  

You can also run everything together via  
``` make run-all ```