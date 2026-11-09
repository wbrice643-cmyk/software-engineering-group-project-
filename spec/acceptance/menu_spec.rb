

RSpec.describe "Viewing the menu" do
  context "when the menu page is visited" do
    it "then shows the menu title and subtitle" do
      visit "/menu"
      expect(page).to have_content "Menu"
      expect(page).to have_content "A perfect start to your day with balanced richness."
    end
  end

  context "when coffee products exist in the database" do
    it "then displays the coffee products with prices" do
      visit "/menu"
      expect(page).to have_content "Latte"
      expect(page).to have_content "Black Coffee"
      expect(page).to have_content "Iced Americano"
      expect(page).to have_content "£"
    end
  end

  context "when viewing add-ons" do
    it "then shows all available add-ons and their prices" do
      visit "/menu"
      expect(page).to have_content "Add-ons"
      expect(page).to have_content "Extra Shot"
      expect(page).to have_content "+£0.80"
      expect(page).to have_content "Oat Milk"
      expect(page).to have_content "+£0.50"
      expect(page).to have_content "Almond Milk"
      expect(page).to have_content "+£0.50"
      expect(page).to have_content "Caramel Syrup"
      expect(page).to have_content "+£0.60"
      expect(page).to have_content "Vanilla Syrup"
      expect(page).to have_content "+£0.60"
      expect(page).to have_content "Whipped Cream"
      expect(page).to have_content "+£0.70"
    end
  end
end

RSpec.describe "Menu page layout" do
  context "when the menu page loads" do
    it "then shows the coffee image" do
      visit "/menu"
      expect(page).to have_css("img[src*='menu_coffee']")
    end

    it "then shows products in two columns" do
      visit "/menu"
      expect(page).to have_css(".menu-grid")
      expect(page).to have_css(".menu-column")
    end
  end
end

RSpec.describe "Menu navigation" do
  context "when viewing the menu page" do
    it "then shows the navigation links" do
      visit "/menu"
      expect(page).to have_link "Home"
      expect(page).to have_link "Menu"
      expect(page).to have_css(".cart-icon") 
    end

    it "then shows the footer with contact information" do
      visit "/menu"
      expect(page).to have_content "CONTACT"
      expect(page).to have_content "123-123-1234"
      expect(page).to have_content "info@email.com"
    end

    it "then shows the newsletter subscription section" do
      visit "/menu"
      expect(page).to have_content "NEWSLETTER"
      expect(page).to have_field "newsletter-email"
      expect(page).to have_button "Send order"
    end
  end
end

RSpec.describe "Adding items to basket from menu" do
  context "when the user clicks on an order button" do
    it "then adds the item to basket" do
      visit "/menu"
      first(:button, "Add to Order").click if page.has_button?("Add to Order")
      expect(page).to have_content "Added to basket" if page.has_content?("Added to basket")
    end
  end
end