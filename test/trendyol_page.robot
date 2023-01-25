*** Settings ***
Library       Collections
Library       SeleniumLibrary
Library    XML
Library    Collections
Library    OperatingSystem

*** Variables ***
${URL}  https://www.trendyol.com
${ACCEPT_COOKIES}  css:div #onetrust-accept-btn-handler
${SEARCH_AREA}  css:#autoCompleteAppWrapper input
${SEARCH_BUTTON}  css:#autoCompleteAppWrapper i
${ADD_TO_FAVORITES}   xpath=(//i[@class='fvrt-btn'])[1]
${LOGIN_EMAIL}  css:#login-email
${LOGIN_PASSWORD}   css:#login-password-input
${LOGIN_BUTTON}  css:div .q-primary
${GO_TO_FAVORITES}  css:.account-favorites
${ADD_TO_BASKET}    css:.p-card-wrppr:nth-of-type(1)
${INCREASE_BUTTON}  css:div:nth-of-type(1) .pb-merchant-group button.ty-numeric-counter-button:nth-of-type(2)
${CLEAR_BUTTON}     xpath:(//i[@class="i-trash"])[1]
${INPUT_QUANTITY}   css:div:nth-of-type(1) .pb-merchant-group .counter-content
${GO_TO_BASKET}     css:.account-basket
${BASKET_PAGE}      css:#basket-app-container
${ONBOARDING_OVERLAY}   css:.onboarding-overlay
${BASKET_TOOLTIP}   css:.tooltip-content button
${number}   TRUE
${is_valid}  True
${x}    5
*** Keywords ***
Open Browser
    Create Webdriver    Chrome    executable_path=resources/chromedriver
    Go To  ${URL}
    Maximize Browser Window
    Element Should Be Visible   ${ACCEPT_COOKIES}
    Click Element   ${ACCEPT_COOKIES}
    #Click Elementcss:.modal-close

Login Page
    [Arguments]  ${EMAIL}   ${PASSWORD}
    Sleep    1s
    Element Should Be Visible   ${LOGIN_EMAIL}
    Input Text  ${LOGIN_EMAIL}  ${EMAIL}
    Input Text  ${LOGIN_PASSWORD}   ${PASSWORD}
    Click Element   ${LOGIN_BUTTON}

Search Product
    [Arguments]  ${product}
    # Ürün arama
    Input Text  ${SEARCH_AREA}  ${product}
    Click Element  ${SEARCH_BUTTON}

Add Fourth Product To Favorites
    # 4. arama sonucundaki ürünü favorilere ekliyor
    #Click Element  css:div.p-card-wrppr:nth-of-type(5) .fvrt-btn
    Click Element  ${ADD_TO_FAVORITES}


Go To Favorites
   Sleep    1s
   Click Element    ${GO_TO_FAVORITES}

    #Click Element  css:.account-favorites

Add Product From Favorites To Cart
    # Favorilerdeki ürünü sepete ekliyor
    Wait Until Element Is Visible   ${ADD_TO_BASKET}    2s
    Click Element  ${ADD_TO_BASKET}

Set Product Quantity
    [Arguments]  ${quantity}
    # Sepetteki ürün miktarını belirliyor
    Click Element   ${GO_TO_BASKET}
    Wait Until Element Is Visible   ${BASKET_PAGE}  3s
    Sleep    1s
    ${is_valid}  Run Keyword And Return Status  Element Should Be Enabled  ${ONBOARDING_OVERLAY}
    IF    ${is_valid}
        Log To Console    "Ekranda Pop-Up Açıldı"
        Click Element    ${BASKET_TOOLTIP}
    ELSE
        Log To Console    "Ekranda Pop-Up Açılmadı"
    END

    ${Increase_Button_Find}  Run Keyword And Return Status  Element Should Be Visible   ${INCREASE_BUTTON}

    IF  ${Increase_Button_Find}
        Click Element   ${INCREASE_BUTTON}
        Input Text  ${INPUT_QUANTITY}   ${quantity}
        Log To Console    "Ürün Sayısı arrtırıldı"

    ELSE
        Click Element   ${CLEAR_BUTTON}
        Log To Console    "Ürün Sepetten Kaldırıldı"

    END


