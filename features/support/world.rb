module AuthHelper
  def login_for_user(id)
    user = User.find(id)
    visit(login_path)
    fill_in( "Name", with: user.name )
    fill_in( "Password", with: "st3rk3ts" )
    click_button( "Login" )

    if page.has_content?("You are logged in")
      return true
    else 
      return false
    end
  end

  def create_user
    return FactoryGirl.create(:user)
  end
end



World(AuthHelper)