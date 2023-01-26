*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource  trendyol_page.robot
Library    XML
Library    Collections
Library    OperatingSystem
Test Teardown   Close Browser



*** Test Cases ***
Test Trendyol
    Open Browser
    Search Product  bilgisayar
    Add Fourth Product To Favorites
    Login Page    trendyolotomasyontest@test.com    trendyoltest123
    Go To Favorites
    Add Product From Favorites To Cart
    Set Product Quantity  3
