RSpec.describe "Visiting home page" do
  context "When clicking on the home link" do
    it "Visits the home page" do
      visit "/menu"
      click_on "Home"
      expect(page).to have_content "What we offer"
    end
  end
end

describe "Visiting menu page" do
  context "When clicking on the menu link" do
    it "Visits the menu page" do
      visit "/"
      click_on "Menu"
      expect(page).to have_content "Menu"
      expect(page).to have_content "A perfect start to your day with balanced richness."
    end
  end
end

describe "Visiting orders page" do
  context "When clicking on the orders link" do
    it "Visits the orders page" do
      visit "/"
      click_on "Shop"
      expect(page).to have_content "Welcome! What would you like to order?"
    end
  end
end

describe "Visiting login page" do
  context "When clicking on the login link" do
    it "Visits the login page" do
      visit "/"
      click_on "Login In"
      expect(page).to have_content "Sign Up"
    end
  end
end

describe "Visiting your orders page" do
  context "When clicking on the your orders link" do
    it "Visits the your orders page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "customer@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Your Orders"
      expect(page).to have_content "Orders"
      expect(page).to have_content "no data found"
    end
  end
end

describe "Visiting loyalty card page" do
  context "When clicking on the loyalty card link" do
    it "Visits the loyalty card page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "customer@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Loyalty Card"
      expect(page).to have_content "Number of Loyalty points"
    end
  end
end

describe "Visiting customer database page" do
  context "When clicking on the customer database link" do
    it "Visits the customer database page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "manager@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Customer Database"
      expect(page).to have_content "Customer Database"
    end
  end
end

describe "Visiting product database page" do
  context "When clicking on the product database link" do
    it "Visits the product database page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "manager@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Product Database"
      expect(page).to have_content "Product Database"
    end
  end
end

describe "Visiting orders database page" do
  context "When clicking on the orders database link" do
    it "Visits the orders card page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "manager@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Orders Database"
      expect(page).to have_content "Orders"
    end
  end
end

describe "Visiting customer database page" do
  context "When clicking on the customer database link" do
    it "Visits the customer database page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "admin@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Customer Database"
      expect(page).to have_content "Customer Database"
    end
  end
end

describe "Visiting product database page" do
  context "When clicking on the product database link" do
    it "Visits the product database page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "admin@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Product Database"
      expect(page).to have_content "Product Database"
    end
  end
end

describe "Visiting orders database page" do
  context "When clicking on the orders database link" do
    it "Visits the orders card page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "admin@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Orders Database"
      expect(page).to have_content "Orders"
    end
  end
end

describe "Visiting create account page" do
  context "When clicking on the create account link" do
    it "Visits the create account page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "admin@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Create Account"
      expect(page).to have_content "Account Type:"
    end
  end
end

describe "Visiting add product page" do
  context "When clicking on the add product link" do
    it "Visits the add product page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "admin@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Add Product"
      expect(page).to have_content "Add Coffee Beans"
    end
  end
end

describe "Visiting customer database page" do
  context "When clicking on the customer database link" do
    it "Visits the customer database page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "barista@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Customer Database"
      expect(page).to have_content "Customer Database"
    end
  end
end

describe "Visiting product database page" do
  context "When clicking on the product database link" do
    it "Visits the product database page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "barista@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Product Database"
      expect(page).to have_content "Product Database"
    end
  end
end

describe "Visiting orders database page" do
  context "When clicking on the orders database link" do
    it "Visits the orders card page" do
      visit "/"
      click_on "Login In"
      fill_in "email", with: "barista@test.com"
      fill_in "password", with: "password"
      click_on "Sign In"
      click_on "Orders Database"
      expect(page).to have_content "Orders"
    end
  end
end