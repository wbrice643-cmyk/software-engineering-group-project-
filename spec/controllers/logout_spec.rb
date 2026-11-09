RSpec.describe "log out" do
  context "when the page is visited" do
    it "loads homepage" do
      visit "/"
      click_on "Menu"
      visit "/logout"
      expect(page).to have_content "What we offer"
    end
  end
end