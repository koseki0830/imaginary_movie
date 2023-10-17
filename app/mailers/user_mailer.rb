class UserMailer < ApplicationMailer
  default from: 'from@example.com'
  def reset_password_email
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_passoword_token)

    mail(to: user.email, subject: 'パスワードリセット')
  end
end
