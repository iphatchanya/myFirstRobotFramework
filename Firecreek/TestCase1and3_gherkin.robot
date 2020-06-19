*** Settings ***
Library         Selenium2Library
Library         String


*** Variables ***
${URL}                    https://staging.arthuronline.co.uk/users/lockdown
${BROWSER}                chrome
${ACCESS_PASSWORD}        arthur888
${EMAIL_ADDRESS}          dhruv+FCQA1@firecreekweb.com
${PASSWORD}               Qwerty66#

*** Test Cases ***
Scenario: Login to system
  Given I'm a Property Manager
  And I have an existing account on Arthur Online
  And I have unlocked Arthur with the password which has been provided to me
  When I proceed to the Arthur login page 
  And I add in my email address and password which has been provided to me
  And I click on the log in button
  Then I will be able to login to Arthur 


Scenario: Logout of system
  Given I'm a Property Manager
  And I am logged into the system already
  When I click on my account image
  And I will see a panel called account open after that
  And I click on the drop down
  And I click on sign out
  Then I will be redirected to the Arthur lockdown page
  And I am able to add the password to unlock Arthur 
  And I am redirected again back to the Arthur login page

*** Keywords ***
I have an existing account on Arthur Online
    Open Browser  ${URL}  ${BROWSER}

I have unlocked Arthur with the password which has been provided to me
    Input Text  name=data[User][lockdown_password]  ${ACCESS_PASSWORD}

I proceed to the Arthur login page 
    Submit Form

I add in my email address and password which has been provided to me
    Input Text  name=data[User][email]  ${EMAIL_ADDRESS}
    Input Text  name=data[User][password]  ${PASSWORD}

I click on the log in button
    Submit Form

I click on my account image
  Click Element   css:div.account-text

I will see a panel called account open after that
  BuiltIn.Sleep   3s

I click on the drop down
  Click Element   css:button.btn.btn-secondary.no-shadow
  BuiltIn.Sleep   3s

I click on sign out
    Click Element   xpath=(//a[contains(text(),'Sign Out')])[2]

I will be redirected to the Arthur lockdown page
    Wait until Page Contains Element  xpath://strong[contains(text(),'This section on Arthur is locked')]

I am able to add the password to unlock Arthur 
    Input Text  name=data[User][lockdown_password]  ${ACCESS_PASSWORD}
    Submit Form

I am redirected again back to the Arthur login page
  Wait until Page Contains Element  xpath://form[@action='/login']