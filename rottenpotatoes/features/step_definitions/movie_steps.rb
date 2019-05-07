# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(title: movie[:title], rating: movie[:rating], release_date: movie[:release_date])
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |m1, m2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(/[\S\s]*#{m1}[\S\s]*#{m2}/).to match(page.body)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  ratings.each do |rating|
    uncheck ? uncheck("ratings[#{rating}]") : (check("ratings[#{rating}]"))
  end
end


Then /I should see the following movies: (.*)$/ do |movies_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  movies = movies_list.split(', ')
  movies.each do |movie|
      expect(page).to have_content(movie)
  end
end

Then /I should not see the following movies: (.*)$/ do |movies_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  movies = movies_list.split(', ')
  movies.each do |movie|
      expect(page).not_to have_content(movie)
  end
end



Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
   expect(page).to have_css("tr", count: 11)
end


When(/^I press "([^"]*)" button$/) do |arg1|
  click_on arg1
end 
