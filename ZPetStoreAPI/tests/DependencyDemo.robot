*** Settings ***
Library    DependencyLibrary
*** Test Cases ***
Test case x
    Log To Console    Task one done   
# *** Test Cases ***
Test that depends on a task
    Depends On Test    Test case x
    Log To Console    I'm running ...    
 
Test depends on a task
    Depends On Suite    PrepTasks
    Log To Console    Test depends on taks    