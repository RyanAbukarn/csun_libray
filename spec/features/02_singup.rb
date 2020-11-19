require 'rails_helper'


feature 'login page: validate page element' do
    background do
        visit 'signup'
    end
    scenario 'sign up with a valid informations', js: true do
        user = create(:user)
        fill_in "user_fname",	with: user.fname
        fill_in "user_lname", with: user.lname
        fill_in "user_email",	with: user.email
        fill_in "user_phone",	with: user.phone
        fill_in "user_address",	with: user.address
        fill_in "user_password", with: "123456"
        select 'California', from: 'user_state'
        select 'San Diego', from: 'user_city'
        click_button("Submit")
        expect(page).to have_content("Sign Out")
    end
end