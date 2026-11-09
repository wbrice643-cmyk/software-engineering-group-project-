RSpec.describe "Visiting orders page" do
  context "When clicking on the orders link" do
    it "Visits the orders page" do
      visit "/"
      click_on "Order now"
      expect(page).to have_content "Welcome! What would you like to order?"
    end
  end
end

describe "Viewing second page" do
  context "When viewing the page" do
    it "Shows the correct content" do
      visit "/"
      expect(page).to have_content "Your coffee"
      expect(page).to have_content "Seamlessly Brewed"
      expect(page).to have_content "Made for mornings meetings and everything in between."
    end
  end
end

describe "Viewing third page" do
  context "When viewing the page" do
    it "Shows the correct content" do
      visit "/"
      expect(page).to have_content "Sheffield"
      expect(page).to have_content "Openning hours"
      expect(page).to have_content "Mon-Fri: 9AM-5PM"
    end
  end
end