*** Settings ***
Library    String
Library    Jinjawrapper.py
Library    OperatingSystem
*** Test Cases ***
Test format with default values
    ${template}    Set Variable    {{"key0":{value0} }}
    ${txt}    Format String    ${template}   value0=123
    Log To Console    ${txt}    
    
    
Test format with default values jinja
    ${template}    Set Variable    {"key0":{{value0|default(true,true)}}}
    ${txt}    Render The Template    ${template}   value0=false
    Log To Console    ${txt} 
    ${txt}    Render The Template    ${template}
    Log To Console    ${txt}

Test create json body from template file
    ${template}    Get File    ./templates/PetSample.template
    ${txt}    Render The Template    ${template}   name=petname    id=123    categoryID=0    categoryName=dog    status=zeft
    Log To Console    ${txt} 

Test create json body from template file with default
    ${template}    Get File    ./templates/PetSample.template
    ${txt}    Render The Template    ${template}   name=petname2    id=456    categoryID=1    categoryName=dog
    Log To Console    ${txt} 
    