*** Variables ***
${Base}    https://petstore.swagger.io
${MyAPIkey}    MyAPIkey
*** Settings ***
Library    String    
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    ./upload.py            
Test Setup    Create session    session     url=${Base}    verify=True
*** Keywords ***
Add a pet
    ${body}    Get File    ${CURDIR}/PetSample.json
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Post Request    session    uri=/v2/pet    headers=${hdrs}    data=${body}
    [Return]    ${resp}
*** Test Cases ***
Test add pet
    ${resp}    Add a pet    
    Should Be Equal As Strings    ${resp.status_code}    200
    Log     ${resp.json()['id']}


Test uppload pet image
    ${resp}    Add a pet    
    Should Be Equal As Strings    ${resp.status_code}    200
    Log     ${resp.json()['id']}
    # &{hdrs}    Create Dictionary    Content-Type=multipart/form-data
    # ${file_data}=  Get Binary File  ${CURDIR}${/}petimage.jpg
    # @{files}    Create List    file    ${file_data}    
    # ${resp}    Post Request    session    uri=/v2/pet/123/uploadImage    headers=${hdrs}    files=${files}
    ${resp}    Upload Image    ${Base}/v2/pet/123/uploadImage    file_path=${CURDIR}${/}petimage.jpeg
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
        
    
Test Update pet data    
    ${resp}    Add a pet
    Should Be Equal As Strings    ${resp.status_code}    200    msg=Failed to add a pet :${resp.content}  
    # Get the pet id to update
    Log        ${resp.json()['id']}  
    ${body}    Get File    ${CURDIR}/PetUpdate.json
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Put Request    session    uri=/v2/pet    headers=${hdrs}        data=${body}
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
    Log    ${resp.content}
    Should Be Equal As Strings    ${resp.json()['status']}    Sold    msg=${resp.content}


Test find pet by status available
    #  /v2/pet/findByStatus?status=available    
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Get Request    session    uri=/v2/pet/findByStatus?status=available
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
    
Test find pet by status pending
    #  /v2/pet/findByStatus?status=available    
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Get Request    session    uri=/v2/pet/findByStatus?status=pending
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
    
    
Test find pet by status sold
    #  /v2/pet/findByStatus?status=available    
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Get Request    session    uri=/v2/pet/findByStatus?status=sold
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}


Get Pet by Id
    ${resp}    Add a pet
    Should Be Equal As Strings    ${resp.status_code}    200    msg=Failed to add a pet :${resp.content}  
    # Get the pet id
    Log        ${resp.json()['id']}  
    ${body}    Get File    ${CURDIR}/PetUpdate.json
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Get Request    session    uri=/v2/pet/${resp.json()['id']}      headers=${hdrs}
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
    Log    ${resp.content}
    Should Be Equal As Strings    ${resp.json()['name']}    pet0    msg=${resp.content}
    
Test Update pet form data    
    ${resp}    Add a pet
    Should Be Equal As Strings    ${resp.status_code}    200    msg=Failed to add a pet :${resp.content}  
    # Get the pet id to update
    Log        ${resp.json()['id']}
    ${id}    Set Variable    ${resp.json()['id']} 
    &{body}    Create Dictionary    name=pet0update    status=pending
    &{hdrs}    Create Dictionary    Content-Type=application/json
    ${resp}    Post Request    session    uri=/v2/pet/${resp.json()['id']}    headers=${hdrs}        data=${body}
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
    Log    ${resp.content}
    Should Be Equal As Strings    ${resp.json()['name']}        pet0update    msg=Faile to update the name: ${resp.content}
    Should Be Equal As Strings    ${resp.json()['status']}      pending       msg=Faile to update the status: ${resp.content}
    
    

Test Delete a pet    
    ${resp}    Add a pet
    Should Be Equal As Strings    ${resp.status_code}    200    msg=Failed to add a pet :${resp.content}  
    # Get the pet id
    Log        ${resp.json()['id']}
    ${id}    Set Variable    ${resp.json()['id']} 
    &{hdrs}    Create Dictionary    Content-Type=application/json    api_key=${MyAPIkey}
    ${resp}    Delete Request    session    uri=/v2/pet/123    headers=${hdrs}
    Should Be Equal As Strings    ${resp.status_code}    200    msg=${resp.content}
    Log    ${resp.content}

        