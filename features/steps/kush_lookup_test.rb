class Spinach::Features::KushLookupTest < Spinach::FeatureSteps
  step 'I have the strain search form' do
    visit '/'
  end

  step 'I fill in kush' do
    fill_in 'strain', with: "kush"
  end

  step 'I submit the form' do
    click_button('strain search')
    #Wait for all ajax calls
    sleep 1
    #screenshot_and_open_image
    within('.searchBar') do 
    expect(page).to have_content('goo')
    end
    #loop until page.evaluate_script('jQuery.active').try(:zero?)
  end

  step 'results should include a paper-card element' do
     within('.searchBar') do  
      expect(page).to have_content('THC')
     end
  end
end