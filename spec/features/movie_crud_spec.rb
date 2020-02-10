require "rails_helper"

feature "MOVIES" do
  describe "/movies" do
    it "has the title of every row", points: 5 do
      test_movies = create_list(:movie, 5)

      visit "/movies"

      test_movies.each do |current_movie|
        expect(page).to have_content(current_movie.title)
      end
    end
  end

  describe "/movies" do
    it "has the year of every row", points: 5 do
      test_movies = create_list(:movie, 5)

      visit "/movies"

      test_movies.each do |current_movie|
        expect(page).to have_content(current_movie.year)
      end
    end
  end

  describe "/movies" do
    it "has the duration of every row", points: 5 do
      test_movies = create_list(:movie, 5)

      visit "/movies"

      test_movies.each do |current_movie|
        expect(page).to have_content(current_movie.duration)
      end
    end
  end

  describe "/movies" do
    it "has the description of every row", points: 5 do
      test_movies = create_list(:movie, 5)

      visit "/movies"

      test_movies.each do |current_movie|
        expect(page).to have_content(current_movie.description)
      end
    end
  end

  describe "/movies" do
    it "has the image url of every row", points: 5 do
      test_movies = create_list(:movie, 5)

      visit "/movies"

      test_movies.each do |current_movie|
        expect(page).to have_css("img[src*='#{current_movie.image}']")
      end
    end
  end

  describe "/movies" do
    it "has a link to the details page of every row", points: 5 do
      test_movies = create_list(:movie, 5)

      visit "/movies"

      test_movies.each do |current_movie|
        expect(page).to have_css("a[href*='#{current_movie.id}']", text: "Show details")
      end
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has the correct title", points: 3 do
      movie_to_show = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_show.id}']", text: "Show details").click

      expect(page).to have_content(movie_to_show.title)
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has the correct year", points: 3 do
      movie_to_show = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_show.id}']", text: "Show details").click

      expect(page).to have_content(movie_to_show.year)
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has the correct duration", points: 3 do
      movie_to_show = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_show.id}']", text: "Show details").click

      expect(page).to have_content(movie_to_show.duration)
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has the correct description", points: 3 do
      movie_to_show = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_show.id}']", text: "Show details").click

      expect(page).to have_content(movie_to_show.description)
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has the correct image url", points: 3 do
      movie_to_show = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_show.id}']", text: "Show details").click
      expect(page).to have_css("img[src*='#{movie_to_show.image}']")
    end
  end

  describe "/movies" do
    it "has a link to the new movie page", points: 2 do
      visit "/movies"

      expect(page).to have_css("a", text: "Add a new movie")
    end
  end

  describe "/movies/new" do
    it "saves the title when submitted", points: 2, hint: h("label_for_input") do
      visit "/movies"
      click_on "Add a new movie"

      test_title = "A fake title I'm typing at #{Time.now}"
      fill_in "Title", with: test_title

      click_on "Create movie"

      last_movie = Movie.order(created_at: :asc).last
      expect(last_movie.title).to eq(test_title)
    end
  end

  describe "/movies/new" do
    it "saves the year when submitted", points: 2, hint: h("label_for_input") do
      visit "/movies"
      click_on "Add a new movie"

      test_year = "A fake year I'm typing at #{Time.now}"
      fill_in "Year", with: test_year

      click_on "Create movie"

      last_movie = Movie.order(created_at: :asc).last
      expect(last_movie.year).to eq(test_year)
    end
  end

  describe "/movies/new" do
    it "saves the duration when submitted", points: 2, hint: h("label_for_input") do
      visit "/movies"
      click_on "Add a new movie"

      test_duration = rand(1000)
      fill_in "Duration", with: test_duration

      click_on "Create movie"

      last_movie = Movie.order(created_at: :asc).last
      expect(last_movie.duration).to eq(test_duration)
    end
  end

  describe "/movies/new" do
    it "saves the description when submitted", points: 2, hint: h("label_for_input") do
      visit "/movies"
      click_on "Add a new movie"

      test_description = "A fake description I'm typing at #{Time.now}"
      fill_in "Description", with: test_description

      click_on "Create movie"

      last_movie = Movie.order(created_at: :asc).last
      expect(last_movie.description).to eq(test_description)
    end
  end

  describe "/movies/new" do
    it "saves the image url when submitted", points: 2, hint: h("label_for_input") do
      visit "/movies"
      click_on "Add a new movie"

      test_image = "A fake image url I'm typing at #{Time.now}"
      fill_in "Image url", with: test_image

      click_on "Create movie"

      last_movie = Movie.order(created_at: :asc).last
      expect(last_movie.image).to eq(test_image)
    end
  end

  describe "/movies/new" do
    it "redirects to the index when submitted", points: 2, hint: h("redirect_vs_render") do
      visit "/movies"
      click_on "Add a new movie"

      click_on "Create movie"

      expect(page).to have_current_path("/movies")
    end
  end

  describe "/movies/new" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      visit "/movies"

      expect(page).to_not have_content("Movie created successfully.")

      click_on "Add a new movie"
      click_on "Create movie"

      expect(page).to have_content("Movie created successfully.")
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has a 'Delete movie' link", points: 2 do
      movie_to_delete = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_delete.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Delete")
    end
  end

  describe "/delete_movie/[MOVIE ID]" do
    it "removes a row from the table", points: 5 do
      movie_to_delete = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_delete.id}']", text: "Show details").click
      click_on "Delete movie"

      expect(Movie.exists?(movie_to_delete.id)).to be(false)
    end
  end

  describe "/delete_movie/[MOVIE ID]" do
    it "redirects to the index", points: 3, hint: h("redirect_vs_render") do
      movie_to_delete = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_delete.id}']", text: "Show details").click
      click_on "Delete movie"

      expect(page).to have_current_path("/movies")
    end
  end

  describe "/delete_movie/[MOVIE ID]" do
    it "redirects to the index with a notice", points: 3, hint: h("copy_must_match") do
      movie_to_delete = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_delete.id}']", text: "Show details").click

      expect(page).to_not have_content("Movie deleted successfully.")

      click_on "Delete movie"

      expect(page).to have_content("Movie deleted successfully.")
    end
  end

  describe "/movies/[MOVIE ID]" do
    it "has an 'Edit movie' link", points: 5 do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click

      expect(page).to have_css("a", text: "Edit movie")
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "has title pre-populated", points: 3, hint: h("value_attribute") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      expect(page).to have_css("input[value='#{movie_to_edit.title}']")
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "has year pre-populated", points: 3, hint: h("value_attribute") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      expect(page).to have_css("input[value='#{movie_to_edit.year}']")
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "has duration pre-populated", points: 3, hint: h("value_attribute") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      expect(page).to have_css("input[value='#{movie_to_edit.duration}']")
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "has description pre-populated", points: 3, hint: h("value_attribute") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      expect(page).to have_content(movie_to_edit.description)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "has image url pre-populated", points: 3, hint: h("value_attribute") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      expect(page).to have_css("input[value='#{movie_to_edit.image}']")
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "updates title when submitted", points: 5, hint: h("label_for_input button_type") do
      movie_to_edit = create(:movie, title: "Boring old title")

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      test_title = "Exciting new title at #{Time.now}"
      fill_in "Title", with: test_title

      click_on "Update movie"

      movie_as_revised = Movie.find(movie_to_edit.id)

      expect(movie_as_revised.title).to eq(test_title)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "updates year when submitted", points: 5, hint: h("label_for_input button_type") do
      movie_to_edit = create(:movie, year: "Boring old year")

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      test_year = "Exciting new year at #{Time.now}"
      fill_in "Year", with: test_year

      click_on "Update movie"

      movie_as_revised = Movie.find(movie_to_edit.id)

      expect(movie_as_revised.year).to eq(test_year)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "updates duration when submitted", points: 5, hint: h("label_for_input button_type") do
      movie_to_edit = create(:movie, duration: "Boring old duration")

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      test_duration = rand(1000)
      fill_in "Duration", with: test_duration

      click_on "Update movie"

      movie_as_revised = Movie.find(movie_to_edit.id)

      expect(movie_as_revised.duration).to eq(test_duration)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "updates description when submitted", points: 5, hint: h("label_for_input button_type") do
      movie_to_edit = create(:movie, description: "Boring old description")

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      test_description = "Exciting new description at #{Time.now}"
      fill_in "Description", with: test_description

      click_on "Update movie"

      movie_as_revised = Movie.find(movie_to_edit.id)

      expect(movie_as_revised.description).to eq(test_description)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "updates image url when submitted", points: 5, hint: h("label_for_input button_type") do
      movie_to_edit = create(:movie, image: "Boring old image url")

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      click_on "Edit movie"

      test_image = "Exciting new image url at #{Time.now}"
      fill_in "Image url", with: test_image

      click_on "Update movie"

      movie_as_revised = Movie.find(movie_to_edit.id)

      expect(movie_as_revised.image).to eq(test_image)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "redirects to the details page", points: 3, hint: h("embed_vs_interpolate redirect_vs_render") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click
      details_page_path = page.current_path

      click_on "Edit movie"
      click_on "Update movie"

      expect(page).to have_current_path(details_page_path, ignore_query: true)
    end
  end

  describe "/movies/[MOVIE ID]/edit" do
    it "redirects to the details page with a notice", points: 3, hint: h("copy_must_match") do
      movie_to_edit = create(:movie)

      visit "/movies"
      find("a[href*='#{movie_to_edit.id}']", text: "Show details").click

      expect(page).to_not have_content("Movie updated successfully.")

      click_on "Edit movie"
      click_on "Update movie"

      expect(page).to have_content("Movie updated successfully.")
    end
  end
end
