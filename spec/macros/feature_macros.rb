module FeatureMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_login', with: user.username
    fill_in 'user_password', with: user.password
    click_on t('devise.sessions.new.sign_in')
  end

  def sign_out
    click_on 'Log out'
  end

  def mail_confirmation(email)
    fill_in 'email', with: email
    click_button 'submit'
  end

  def visit_user(user)
    login_as(user)
    visit root_path
    # visit question_path(question)
  end

  def visit_quest
    visit root_path
  end

  def visit_chat_writer(chat)
    login_as(writer)
    visit chat_path(chat)
  end

  def visit_chat_reader(chat)
    login_as(reader)
    visit chat_path(chat)
  end
end
