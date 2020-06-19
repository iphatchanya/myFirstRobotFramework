*** Settings ***
Library         Selenium2Library
Library         String


*** Variables ***
${URL}                    https://staging.arthuronline.co.uk/users/lockdown
${BROWSER}                chrome
${ACCESS_PASSWORD}        arthur888
${EMAIL_ADDRESS}          dhruv+FCQA1@firecreekweb.com
${PASSWORD}               Qwerty66#
${PROPERTY_NAME}          TestCondo1
${PROPERTY_ADDRESS}       50, Latyao, Chatujak, Bangkok, Thailand 10900
${OWNER_FIRST_NAME}       Phatchanya
${OWNER_LAST_NAME}        Chongcheevewat
${PROPERTY_UNIT}          2

*** Test Cases ***
Scenario: Login to system
    Given I'm a Property Manager
    And I have an existing account on Arthur Online
    And I have unlocked Arthur with the password which has been provided to me
    When I proceed to the Arthur login page 
    And I add in my email address and password which has been provided to me
    And I click on the log in button
    Then I will be able to login to Arthur 

Scenario: Add a property with a multiple rentable units
    Given I'm a Property Manager
    And I am logged into the system already
    When I click on Properties dropdown on the left hand panel 
    And I click on the Add property button
    And I select property with a multiple rentable units option
    And I enter all the required fields in the input text boxes
    And I select the number of rentable units to be any number <1
    And I click on the Next, Units Settings button
    And I select all required fields
    And I click on Add Property button
    Then I have successfully added a property with a multiple units
    And I click on Properties from the left hand panel
    And I validate that the property I just created is present

*** Keywords ***
I'm a Property Manager
    BuiltIn.Sleep   1s

I have an existing account on Arthur Online
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window

I have unlocked Arthur with the password which has been provided to me
    Input Text  name=data[User][lockdown_password]  ${ACCESS_PASSWORD}

I proceed to the Arthur login page 
    Submit Form

I add in my email address and password which has been provided to me
    Input Text  name=data[User][email]  ${EMAIL_ADDRESS}
    Input Text  name=data[User][password]  ${PASSWORD}

I click on the log in button
    Submit Form

I will be able to login to Arthur
    BuiltIn.Sleep   1s

I am logged into the system already
    BuiltIn.Sleep   1s

I click on Properties dropdown on the left hand panel 
    Click Element  xpath=//ul[@id="main-menu"]/li[3]

I click on the Add property button
    #Wait until Page Contains Element  xpath://a[text()='Add Property']
    #Click Element    xpath=//a[text()='Add Property']
    Wait until Page Contains Element  xpath://a[@href='/candidate/properties/add']
    BuiltIn.Sleep   3s
    Click Element   partial link:Add Property

I select property with a multiple rentable units option
    Wait until Page Contains Element  xpath://div[text()='Property with a single rentable unit']
    Click Element       //div[@class="noselect property-description multiple-unit "]

I enter all the required fields in the input text boxes
    Input Text  name=data[Profile][address_name]  ${PROPERTY_NAME}
    Click Element       //div[@id="s2id_PropertyOwnerId"]
    Click Element  xpath=//div[@id="select2-drop"]/ul/li[2]
    Input Text  name=data[Profile][address1]  ${PROPERTY_ADDRESS}

I select the number of rentable units to be any number <1
    Input Text  name=data[Property][unit_count]  ${PROPERTY_UNIT}
    Scroll Element Into View  xpath=//div[@class='page-switcher']  

I click on the Next, Units Settings button
    Click Button    xpath=//input[@value='Next, Units Settings ']
    Wait until Page Contains Element  xpath=//input[@value='Add Property']
    Click Element       //div[@id="s2id_PrefixUnitUnitManagerManagerPersonId"]

I select all required fields
    Click Element  xpath=//div[@id="select2-drop"]/ul/li[2]
    #Select From List by Index    xpath=//select[@id="MultiUnitIdUnitOwnerId"]   1
    Select From List by Index    xpath=(//select[@id="MultiUnitIdUnitOwnerId"])[1]  1
    Select From List by Index    xpath=(//select[@id="MultiUnitIdUnitOwnerId"])[2]  1

I click on Add Property button
    Click Button    xpath=//input[@value='Add Property']

I have successfully added a property with a multiple units
    Wait until Page Contains Element  xpath://h2[text()='Multiple Units Added ']

I click on Properties from the left hand panel
    Click Element  xpath=//ul[@id="main-menu"]/li[3]/a[1]
    
I validate that the property I just created is present
    Wait until Page Contains Element  xpath://a[text()='${PROPERTY_NAME}']
