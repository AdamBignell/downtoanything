require 'spec_helper'

describe "actually search for user" do
	it "should go to the search results" do
		visit "/search/results"
		fill_in('searchform', with: "a")
		click_button('searchbutton')
		page.has_content?('Users')
	end
end