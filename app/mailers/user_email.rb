class UserEmail < ActionMailer::Base
  default from: "mystackoverflow@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_email.verification_letter.subject
  #
  def verification_letter(user)
    @user  = user
    authorization = @user.authorizations.where(confirmed: false).first
    @url = "http://localhost:3000/verifications/#{@user.id}/#{authorization.id}/#{authorization.checksum}/verify"

    mail to: @user.email
  end
end
