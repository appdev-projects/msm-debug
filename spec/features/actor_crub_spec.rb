require "rails_helper"

feature "ACTORS" do
  describe "/actors" do
    it "has the dob of every row", points: 5 do
      test_actors = create_list(:actor, 5)

      visit "/actors"

      test_actors.each do |current_actor|
        expect(page).to have_content(current_actor.dob)
      end
    end
  end

  describe "/actors" do
    it "has the name of every row", points: 5 do
      test_actors = create_list(:actor, 5)

      visit "/actors"

      test_actors.each do |current_actor|
        expect(page).to have_content(current_actor.name)
      end
    end
  end

  describe "/actors" do
    it "has the bio of every row", points: 5 do
      test_actors = create_list(:actor, 5)

      visit "/actors"

      test_actors.each do |current_actor|
        expect(page).to have_content(current_actor.bio)
      end
    end
  end

  describe "/actors" do
    it "has the image url of every row", points: 5 do
      test_actors = create_list(:actor, 5)

      visit "/actors"

      test_actors.each do |current_actor|
        expect(page).to have_css("img[src*='#{current_actor.image}']")
      end
    end
  end

  describe "/actors" do
    it "has a link to the details page of every row", points: 5 do
      test_actors = create_list(:actor, 5)

      visit "/actors"

      test_actors.each do |current_actor|
        expect(page).to have_css("a[href*='#{current_actor.id}']", text: "Show details")
      end
    end
  end

  describe "/actors/[ACTOR ID]" do
    it "has the correct dob", points: 3 do
      actor_to_show = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_show.id}']", text: "Show details").click

      expect(page).to have_content(actor_to_show.dob)
    end
  end

  describe "/actors/[ACTOR ID]" do
    it "has the correct name", points: 3 do
      actor_to_show = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_show.id}']", text: "Show details").click

      expect(page).to have_content(actor_to_show.name)
    end
  end

  describe "/actors/[ACTOR ID]" do
    it "has the correct bio", points: 3 do
      actor_to_show = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_show.id}']", text: "Show details").click

      expect(page).to have_content(actor_to_show.bio)
    end
  end

  describe "/actors/[ACTOR ID]" do
    it "has the correct image url", points: 3 do
      actor_to_show = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_show.id}']", text: "Show details").click
      expect(page).to have_css("img[src*='#{actor_to_show.image}']")
    end
  end

  describe "/actors" do
    it "has a link to the new actor page", points: 2 do
      visit "/actors"

      expect(page).to have_css("a", text: "Add a new actor")
    end
  end

  describe "/actors/new" do
    it "saves the dob when submitted", points: 2, hint: h("label_for_input") do
      visit "/actors"
      click_on "Add a new actor"

      test_dob = "A fake dob I'm typing at #{Time.now}"
      fill_in "Dob", with: test_dob

      click_on "Create actor"

      last_actor = Actor.order(created_at: :asc).last
      expect(last_actor.dob).to eq(test_dob)
    end
  end

  describe "/actors/new" do
    it "saves the name when submitted", points: 2, hint: h("label_for_input") do
      visit "/actors"
      click_on "Add a new actor"

      test_name = "A fake name I'm typing at #{Time.now}"
      fill_in "Name", with: test_name

      click_on "Create actor"

      last_actor = Actor.order(created_at: :asc).last
      expect(last_actor.name).to eq(test_name)
    end
  end

  describe "/actors/new" do
    it "saves the bio when submitted", points: 2, hint: h("label_for_input") do
      visit "/actors"
      click_on "Add a new actor"

      test_bio = "A fake bio I'm typing at #{Time.now}"
      fill_in "Bio", with: test_bio

      click_on "Create actor"

      last_actor = Actor.order(created_at: :asc).last
      expect(last_actor.bio).to eq(test_bio)
    end
  end

  describe "/actors/new" do
    it "saves the image url when submitted", points: 2, hint: h("label_for_input") do
      visit "/actors"
      click_on "Add a new actor"

      test_image = "A fake image url I'm typing at #{Time.now}"
      fill_in "Image url", with: test_image

      click_on "Create actor"

      last_actor = Actor.order(created_at: :asc).last
      expect(last_actor.image).to eq(test_image)
    end
  end

  describe "/actors/new" do
    it "redirects to the index when submitted", points: 2, hint: h("redirect_vs_render") do
      visit "/actors"
      click_on "Add a new actor"

      click_on "Create actor"

      expect(page).to have_current_path("/actors")
    end
  end

  describe "/actors/new" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      visit "/actors"

      expect(page).to_not have_content("Actor created successfully.")

      click_on "Add a new actor"
      click_on "Create actor"

      expect(page).to have_content("Actor created successfully.")
    end
  end

  describe "/actors/[ACTOR ID]" do
    it "has a 'Delete actor' link", points: 2 do
      actor_to_delete = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_delete.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Delete")
    end
  end

  describe "/delete_actor/[ACTOR ID]" do
    it "removes a row from the table", points: 5 do
      actor_to_delete = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_delete.id}']", text: "Show details").click
      click_on "Delete actor"

      expect(Actor.exists?(actor_to_delete.id)).to be(false)
    end
  end

  describe "/delete_actor/[ACTOR ID]" do
    it "redirects to the index", points: 3, hint: h("redirect_vs_render") do
      actor_to_delete = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_delete.id}']", text: "Show details").click
      click_on "Delete actor"

      expect(page).to have_current_path("/actors")
    end
  end

  describe "/delete_actor/[ACTOR ID]" do
    it "redirects to the index with a notice", points: 3, hint: h("copy_must_match") do
      actor_to_delete = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_delete.id}']", text: "Show details").click

      expect(page).to_not have_content("Actor deleted successfully.")

      click_on "Delete actor"

      expect(page).to have_content("Actor deleted successfully.")
    end
  end

  describe "/actors/[ACTOR ID]" do
    it "has an 'Edit actor' link", points: 5 do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Edit actor")
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "has dob pre-populated", points: 3, hint: h("value_attribute") do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      expect(page).to have_css("input[value='#{actor_to_edit.dob}']")
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "has name pre-populated", points: 3, hint: h("value_attribute") do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      expect(page).to have_css("input[value='#{actor_to_edit.name}']")
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "has bio pre-populated", points: 3, hint: h("text_area") do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      expect(page).to have_content(actor_to_edit.bio)
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "has image url pre-populated", points: 3, hint: h("value_attribute") do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      expect(page).to have_css("input[value='#{actor_to_edit.image}']")
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "updates dob when submitted", points: 5, hint: h("label_for_input button_type") do
      actor_to_edit = create(:actor, dob: "Boring old dob")

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      test_dob = "Exciting new dob at #{Time.now}"
      fill_in "Dob", with: test_dob

      click_on "Update actor"

      actor_as_revised = Actor.find(actor_to_edit.id)

      expect(actor_as_revised.dob).to eq(test_dob)
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "updates name when submitted", points: 5, hint: h("label_for_input button_type") do
      actor_to_edit = create(:actor, name: "Boring old name")

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      test_name = "Exciting new name at #{Time.now}"
      fill_in "Name", with: test_name

      click_on "Update actor"

      actor_as_revised = Actor.find(actor_to_edit.id)

      expect(actor_as_revised.name).to eq(test_name)
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "updates bio when submitted", points: 5, hint: h("label_for_input button_type") do
      actor_to_edit = create(:actor, bio: "Boring old bio")

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      test_bio = "Exciting new bio at #{Time.now}"
      fill_in "Bio", with: test_bio

      click_on "Update actor"

      actor_as_revised = Actor.find(actor_to_edit.id)

      expect(actor_as_revised.bio).to eq(test_bio)
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "updates image url when submitted", points: 5, hint: h("label_for_input button_type") do
      actor_to_edit = create(:actor, image: "Boring old image url")

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      click_on "Edit actor"

      test_image = "Exciting new image url at #{Time.now}"
      fill_in "Image url", with: test_image

      click_on "Update actor"

      actor_as_revised = Actor.find(actor_to_edit.id)

      expect(actor_as_revised.image).to eq(test_image)
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "redirects to the details page", points: 3, hint: h("embed_vs_interpolate redirect_vs_render") do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click
      details_page_path = page.current_path

      click_on "Edit actor"
      click_on "Update actor"

      expect(page).to have_current_path(details_page_path, ignore_query: true)
    end
  end

  describe "/actors/[ACTOR ID]/edit" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      actor_to_edit = create(:actor)

      visit "/actors"
      find("a[href*='#{actor_to_edit.id}']", text: "Show details").click

      expect(page).to_not have_content("Actor updated successfully.")

      click_on "Edit actor"
      click_on "Update actor"

      expect(page).to have_content("Actor updated successfully.")
    end
  end
end
