# frozen_string_literal: true

module LoginSupport
  def login_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログインする'
  end
end
