require "rails_helper"

feature "DIRECTORS" do
  describe "/directors" do
    it "has the dob of every row", points: 5 do
      test_directors = create_list(:director, 5)

      visit "/directors"

      test_directors.each do |current_director|
        expect(page).to have_content(current_director.dob)
      end
    end
  end

  describe "/directors" do
    it "has the name of every row", points: 5 do
      test_directors = create_list(:director, 5)

      visit "/directors"

      test_directors.each do |current_director|
        expect(page).to have_content(current_director.name)
      end
    end
  end

  describe "/directors" do
    it "has the bio of every row", points: 5 do
      test_directors = create_list(:director, 5)

      visit "/directors"

      test_directors.each do |current_director|
        expect(page).to have_content(current_director.bio)
      end
    end
  end

  describe "/directors" do
    it "has the image url of every row", points: 5 do
      test_directors = create_list(:director, 5)

      visit "/directors"

      test_directors.each do |current_director|
        expect(page).to have_css("img[src*='#{current_director.image}']")
      end
    end
  end

  describe "/directors" do
    it "has a link to the details page of every row", points: 5 do
      test_directors = create_list(:director, 5)

      visit "/directors"

      test_directors.each do |current_director|
        expect(page).to have_css("a[href*='#{current_director.id}']", text: "Show details")
      end
    end
  end

  describe "/directors/[DIRECTOR ID]" do
    it "has the correct dob", points: 3 do
      director_to_show = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_show.id}']", text: "Show details").click

      expect(page).to have_content(director_to_show.dob)
    end
  end

  describe "/directors/[DIRECTOR ID]" do
    it "has the correct name", points: 3 do
      director_to_show = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_show.id}']", text: "Show details").click

      expect(page).to have_content(director_to_show.name)
    end
  end

  describe "/directors/[DIRECTOR ID]" do
    it "has the correct bio", points: 3 do
      director_to_show = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_show.id}']", text: "Show details").click

      expect(page).to have_content(director_to_show.bio)
    end
  end

  describe "/directors/[DIRECTOR ID]" do
    it "has the correct image url", points: 3 do
      director_to_show = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_show.id}']", text: "Show details").click
      expect(page).to have_css("img[src*='#{director_to_show.image}']")
    end
  end

  describe "/directors" do
    it "has a link to the new director page", points: 2 do
      visit "/directors"

      expect(page).to have_css("a", text: "Add a new director")
    end
  end

  describe "/directors/new" do
    it "saves the dob when submitted", points: 2, hint: h("label_for_input") do
      visit "/directors"
      click_on "Add a new director"

      test_dob = "A fake dob I'm typing at #{Time.now}"
      fill_in "Dob", with: test_dob

      click_on "Create director"

      last_director = Director.order(created_at: :asc).last
      expect(last_director.dob).to eq(test_dob)
    end
  end

  describe "/directors/new" do
    it "saves the name when submitted", points: 2, hint: h("label_for_input") do
      visit "/directors"
      click_on "Add a new director"

      test_name = "A fake name I'm typing at #{Time.now}"
      fill_in "Name", with: test_name

      click_on "Create director"

      last_director = Director.order(created_at: :asc).last
      expect(last_director.name).to eq(test_name)
    end
  end

  describe "/directors/new" do
    it "saves the bio when submitted", points: 2, hint: h("label_for_input") do
      visit "/directors"
      click_on "Add a new director"

      test_bio = "A fake bio I'm typing at #{Time.now}"
      fill_in "Bio", with: test_bio

      click_on "Create director"

      last_director = Director.order(created_at: :asc).last
      expect(last_director.bio).to eq(test_bio)
    end
  end

  describe "/directors/new" do
    it "saves the image url when submitted", points: 2, hint: h("label_for_input") do
      visit "/directors"
      click_on "Add a new director"

      test_image = "A fake image url I'm typing at #{Time.now}"
      fill_in "Image url", with: test_image

      click_on "Create director"

      last_director = Director.order(created_at: :asc).last
      expect(last_director.image).to eq(test_image)
    end
  end

  describe "/directors/new" do
    it "redirects to the index when submitted", points: 2, hint: h("redirect_vs_render") do
      visit "/directors"
      click_on "Add a new director"

      click_on "Create director"

      expect(page).to have_current_path("/directors")
    end
  end

  describe "/directors/new" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      visit "/directors"

      expect(page).to_not have_content("Director created successfully.")

      click_on "Add a new director"
      click_on "Create director"

      expect(page).to have_content("Director created successfully.")
    end
  end

  describe "/directors/[DIRECTOR ID]" do
    it "has a 'Delete director' link", points: 2 do
      director_to_delete = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_delete.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Delete")
    end
  end

  describe "/delete_director/[DIRECTOR ID]" do
    it "removes a row from the table", points: 5 do
      director_to_delete = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_delete.id}']", text: "Show details").click
      click_on "Delete director"

      expect(Director.exists?(director_to_delete.id)).to be(false)
    end
  end

  describe "/delete_director/[DIRECTOR ID]" do
    it "redirects to the index", points: 3, hint: h("redirect_vs_render") do
      director_to_delete = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_delete.id}']", text: "Show details").click
      click_on "Delete director"

      expect(page).to have_current_path("/directors")
    end
  end

  describe "/delete_director/[DIRECTOR ID]" do
    it "redirects to the index with a notice", points: 3, hint: h("copy_must_match") do
      director_to_delete = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_delete.id}']", text: "Show details").click

      expect(page).to_not have_content("Director deleted successfully.")

      click_on "Delete director"

      expect(page).to have_content("Director deleted successfully.")
    end
  end

  describe "/directors/[DIRECTOR ID]" do
    it "has an 'Edit director' link", points: 5 do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Edit director")
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "has dob pre-populated", points: 3, hint: h("value_attribute") do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      expect(page).to have_css("input[value='#{director_to_edit.dob}']")
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "has name pre-populated", points: 3, hint: h("value_attribute") do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      expect(page).to have_css("input[value='#{director_to_edit.name}']")
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "has bio pre-populated", points: 3, hint: h("value_attribute") do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      expect(page).to have_content(director_to_edit.bio)
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "has image url pre-populated", points: 3, hint: h("value_attribute") do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      expect(page).to have_css("input[value='#{director_to_edit.image}']")
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "updates dob when submitted", points: 5, hint: h("label_for_input button_type") do
      director_to_edit = create(:director, dob: "Boring old dob")

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      test_dob = "Exciting new dob at #{Time.now}"
      fill_in "Dob", with: test_dob

      click_on "Update director"

      director_as_revised = Director.find(director_to_edit.id)

      expect(director_as_revised.dob).to eq(test_dob)
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "updates name when submitted", points: 5, hint: h("label_for_input button_type") do
      director_to_edit = create(:director, name: "Boring old name")

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      test_name = "Exciting new name at #{Time.now}"
      fill_in "Name", with: test_name

      click_on "Update director"

      director_as_revised = Director.find(director_to_edit.id)

      expect(director_as_revised.name).to eq(test_name)
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "updates bio when submitted", points: 5, hint: h("label_for_input button_type") do
      director_to_edit = create(:director, bio: "Boring old bio")

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      test_bio = "Exciting new bio at #{Time.now}"
      fill_in "Bio", with: test_bio

      click_on "Update director"

      director_as_revised = Director.find(director_to_edit.id)

      expect(director_as_revised.bio).to eq(test_bio)
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "updates image url when submitted", points: 5, hint: h("label_for_input button_type") do
      director_to_edit = create(:director, image: "Boring old image url")

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      click_on "Edit director"

      test_image = "Exciting new image url at #{Time.now}"
      fill_in "Image url", with: test_image

      click_on "Update director"

      director_as_revised = Director.find(director_to_edit.id)

      expect(director_as_revised.image).to eq(test_image)
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "redirects to the details page", points: 3, hint: h("embed_vs_interpolate redirect_vs_render") do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click
      details_page_path = page.current_path

      click_on "Edit director"
      click_on "Update director"

      expect(page).to have_current_path(details_page_path, ignore_query: true)
    end
  end

  describe "/directors/[DIRECTOR ID]/edit" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      director_to_edit = create(:director)

      visit "/directors"
      find("a[href*='#{director_to_edit.id}']", text: "Show details").click

      expect(page).to_not have_content("Director updated successfully.")

      click_on "Edit director"
      click_on "Update director"

      expect(page).to have_content("Director updated successfully.")
    end
  end
end
