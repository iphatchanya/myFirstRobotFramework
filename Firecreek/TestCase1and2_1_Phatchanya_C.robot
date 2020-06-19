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

*** Keywords ***

*** Test Cases ***
TC01 - Login to system
  Open Browser  ${URL}  ${BROWSER} 
  Input Text  name=data[User][lockdown_password]  ${ACCESS_PASSWORD}
  Submit Form
  Input Text  name=data[User][email]  ${EMAIL_ADDRESS}
  Input Text  name=data[User][password]  ${PASSWORD}
  Submit Form
  
TC02 - Add a property with a single rentable unit
  Click Element  xpath=//ul[@id="main-menu"]/li[3]
  #Wait until Page Contains Element  xpath://a[text()='Add Property']
  #Click Element    xpath=//a[text()='Add Property']
  Wait until Page Contains Element  xpath://a[@href='/candidate/properties/add']
  BuiltIn.Sleep   3s
  Click Element   partial link:Add Property
  Wait until Page Contains Element  xpath://div[text()='Property with a single rentable unit']
  Click Element       //div[@class="noselect property-description single-unit selected"]
  Input Text  name=data[Profile][address_name]  ${PROPERTY_NAME}
  Click Element       //div[@id="s2id_PropertyOwnerId"]
  Click Element  xpath=//div[@id="select2-drop"]/ul/li[2]
  Input Text  name=data[Profile][address1]  ${PROPERTY_ADDRESS}
  Scroll Element Into View  xpath=//div[@class='page-switcher']  
  Click Button    xpath=//input[@value='Add Property']
  Wait until Page Contains Element  xpath://h2[text()='Single Unit Added ']
  Click Element  xpath=//ul[@id="main-menu"]/li[3]/a[1]
  Wait until Page Contains Element  xpath://a[text()='${PROPERTY_NAME}']