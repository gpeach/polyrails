require 'pry'

class Spinach::Features::KushLookupTest < Spinach::FeatureSteps
  step 'I have the strain search form' do
    visit 'http://localhost:3000'
    #expect(page).not_to have_selector('body[unresolved]') 
  end

  step 'I fill in kush' do
    fill_in 'strain', :with => 'kush'
    #find('strain').set('kush')
  end

  step 'I submit the form' do
    click_on 'searchit'
    #find('button#searchit').click
    #binding.pry
    #screenshot_and_open_image
    loop until page.evaluate_script('jQuery.active').try(:zero?)
  end

  step 'results should include a paper-card element' do  
      page.should have_css('paper-card')
      #expect(page).to have_content('THC')
  end
end