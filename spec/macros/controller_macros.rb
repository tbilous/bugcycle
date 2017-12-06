module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
  end

  def login_as_user(user)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end
end
