require 'spec_helper'

describe "actually search for user" do
	before do
		visit "/search/results"
		fill_in('searchform', with: "e")
		find_button('searchbutton').click
	end
	it "should go to the search results" do
		page.should have_content('e')
	end
end