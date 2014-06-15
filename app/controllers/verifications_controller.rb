class VerificationsController < ApplicationController
  def take_email
    @user = User.find(params[:id])
  end

  def send_letter
    @user = User.find(params[:id])
    new_email = params[:user][:new_email]
    if @user.change_email(new_email)
      UserEmail.verification_letter(@user).deliver
      redirect_to root_path, notice: 'We send you letter to your email, check it and go through verification link.'
    else
      flash[:alert] = 'Something goes wrong, try again.'
      render :take_email
    end
  end

  def verify
    @user = User.find(params[:id])
    authorization = @user.authorizations.first
    if params[:checksum] == authorization.checksum
      authorization.update(confirmed: true)
      sign_in_and_redirect @user, event: :authentication
      flash[:nitice] = 'You have been registered successfully'
    else
      @user.destroy
      flash[:alert] = 'You do not verify your account, try again.'
      redirect_to new_user_session_path
    end
  end
end
