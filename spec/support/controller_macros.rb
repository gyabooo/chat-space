module ControllerMacros

  # カリキュラム解答
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  # my answer
  # def login_user
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     user = FactoryBot.create(:user)
  #     sign_in user
  #   end
  # end

  # def login(user)
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     # user = FactoryBot.create(:user)
  #     sign_in user
  #   end
  # end
end
